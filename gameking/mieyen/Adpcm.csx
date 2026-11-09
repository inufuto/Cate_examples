// GameKing BIOS 4-bit ADPCM codec (shared by EncodeWav.csx / MakeSoundRom.csx).
// The decoder reproduces the BIOS interrupt handler (gm218.bin $6619-$66F5):
//   per byte: low nibble first, then high nibble
//   d = Step[(n & 7) | step];  pred = clamp(pred -/+ d, -128, 127)  (minus when n & 8)
//   step: Index[n] == $F8 -> max(0, step - 8), otherwise min($F8, step + Index[n])
// pred and step are both 0 at the start of a sound.

using System;
using System.Collections.Generic;
using System.IO;

public static class GkAdpcm
{
    // gm218.bin $6969 (256 bytes)
    public static readonly byte[] Step =
    {
        0x00, 0x01, 0x02, 0x03, 0x05, 0x06, 0x07, 0x08, 0x00, 0x01, 0x03, 0x04, 0x06, 0x07, 0x09, 0x0A,
        0x00, 0x01, 0x03, 0x04, 0x07, 0x08, 0x0A, 0x0B, 0x01, 0x03, 0x05, 0x07, 0x09, 0x0B, 0x0D, 0x0F,
        0x01, 0x03, 0x05, 0x07, 0x0A, 0x0C, 0x0E, 0x10, 0x01, 0x03, 0x06, 0x08, 0x0B, 0x0D, 0x10, 0x12,
        0x01, 0x03, 0x06, 0x08, 0x0C, 0x0E, 0x11, 0x13, 0x01, 0x04, 0x07, 0x0A, 0x0D, 0x10, 0x13, 0x16,
        0x01, 0x04, 0x07, 0x0A, 0x0E, 0x11, 0x14, 0x17, 0x01, 0x04, 0x08, 0x0B, 0x0F, 0x12, 0x16, 0x19,
        0x02, 0x06, 0x0A, 0x0E, 0x12, 0x16, 0x1A, 0x1E, 0x02, 0x06, 0x0A, 0x0E, 0x13, 0x17, 0x1B, 0x1F,
        0x02, 0x06, 0x0B, 0x0F, 0x15, 0x19, 0x1E, 0x22, 0x02, 0x07, 0x0C, 0x11, 0x17, 0x1C, 0x21, 0x26,
        0x02, 0x07, 0x0D, 0x12, 0x19, 0x1E, 0x24, 0x29, 0x03, 0x09, 0x0F, 0x15, 0x1C, 0x22, 0x28, 0x2E,
        0x03, 0x0A, 0x11, 0x18, 0x1F, 0x26, 0x2D, 0x34, 0x03, 0x0A, 0x12, 0x19, 0x22, 0x29, 0x31, 0x38,
        0x04, 0x0C, 0x15, 0x1D, 0x26, 0x2E, 0x37, 0x3F, 0x04, 0x0D, 0x16, 0x1F, 0x29, 0x32, 0x3B, 0x44,
        0x05, 0x0F, 0x19, 0x23, 0x2E, 0x38, 0x42, 0x4C, 0x05, 0x10, 0x1B, 0x26, 0x32, 0x3D, 0x48, 0x53,
        0x06, 0x12, 0x1F, 0x2B, 0x38, 0x44, 0x51, 0x5D, 0x06, 0x13, 0x21, 0x2E, 0x3D, 0x4A, 0x58, 0x65,
        0x07, 0x16, 0x25, 0x34, 0x43, 0x52, 0x61, 0x70, 0x08, 0x18, 0x29, 0x39, 0x4A, 0x5A, 0x6B, 0x7B,
        0x09, 0x1B, 0x2D, 0x3F, 0x52, 0x64, 0x76, 0x7F, 0x0A, 0x1E, 0x32, 0x46, 0x5A, 0x6E, 0x7F, 0x7F,
        0x0B, 0x21, 0x37, 0x4D, 0x63, 0x79, 0x7F, 0x7F, 0x0C, 0x24, 0x3C, 0x54, 0x6D, 0x7F, 0x7F, 0x7F,
        0x0D, 0x27, 0x42, 0x5C, 0x78, 0x7F, 0x7F, 0x7F, 0x0E, 0x2B, 0x49, 0x66, 0x7F, 0x7F, 0x7F, 0x7F
    };

    // gm218.bin $6A69 (16 bytes). $F8 means "step down by one row".
    public static readonly byte[] Index =
    {
        0xF8, 0xF8, 0xF8, 0xF8, 0x10, 0x20, 0x30, 0x40, 0xF8, 0xF8, 0xF8, 0xF8, 0x10, 0x20, 0x30, 0x40
    };

    // gm218.bin $695B: {$13, $12} for BIOS function $44 argument 0..6
    static readonly byte[,] RateRegs =
    {
        { 0x0C, 0x3F }, { 0x0C, 0xBF }, { 0x0D, 0x3F }, { 0x0D, 0xBF },
        { 0x0E, 0x3F }, { 0x0E, 0xBF }, { 0x0F, 0x3F }
    };

    public const int RateCount = 7;
    public const double PwmRate = 6000000.0 / 128;

    // Output rate of the sound engine (one nibble per PWM interrupt) for rate number 0..6.
    public static double SampleRate(int rateNo)
    {
        if (rateNo < 0 || rateNo >= RateCount) throw new ArgumentOutOfRangeException(nameof(rateNo));
        int counter = (RateRegs[rateNo, 0] << 2) | (RateRegs[rateNo, 1] >> 6);
        return PwmRate / (64 - counter);
    }

    struct State
    {
        public int Pred;
        public int StepIdx;
    }

    static State Apply(State s, int n)
    {
        int d = Step[(n & 7) | s.StepIdx];
        int p = (n & 8) != 0 ? s.Pred - d : s.Pred + d;
        s.Pred = Math.Max(-128, Math.Min(127, p));
        int t = Index[n];
        s.StepIdx = t == 0xF8 ? Math.Max(0, s.StepIdx - 8) : Math.Min(0xF8, s.StepIdx + t);
        return s;
    }

    public static sbyte[] Decode(byte[] data)
    {
        var result = new sbyte[data.Length * 2];
        var s = new State();
        int k = 0;
        foreach (var b in data)
        {
            s = Apply(s, b & 15);
            result[k++] = (sbyte)s.Pred;
            s = Apply(s, b >> 4);
            result[k++] = (sbyte)s.Pred;
        }
        return result;
    }

    // target: samples in the range -128..127. lookahead = 1 also weighs the following sample.
    public static byte[] Encode(double[] target, int lookahead = 1)
    {
        int count = target.Length + (target.Length & 1);
        var data = new byte[count / 2];
        var s = new State();
        for (int i = 0; i < count; i++)
        {
            double t0 = target[Math.Min(i, target.Length - 1)];
            double t1 = target[Math.Min(i + 1, target.Length - 1)];
            int best = 0;
            double bestErr = double.MaxValue;
            for (int n = 0; n < 16; n++)
            {
                var s1 = Apply(s, n);
                double e = (t0 - s1.Pred) * (t0 - s1.Pred);
                if (lookahead > 0 && i + 1 < count)
                {
                    double e1 = double.MaxValue;
                    for (int m = 0; m < 16; m++)
                    {
                        var s2 = Apply(s1, m);
                        e1 = Math.Min(e1, (t1 - s2.Pred) * (t1 - s2.Pred));
                    }
                    e += e1;
                }
                if (e < bestErr)
                {
                    bestErr = e;
                    best = n;
                }
            }
            s = Apply(s, best);
            if ((i & 1) == 0) data[i / 2] = (byte)best;
            else data[i / 2] |= (byte)(best << 4);
        }
        return data;
    }

    // ---- Splitting into several sounds ----------------------------------------------------
    // A sound is limited to 65535 bytes (16 bit length), so longer audio is stored as consecutive
    // sounds that are played by a script of consecutive IDs ("id, id+1, ..., $FF").
    // What the BIOS does at a seam (gm218.bin $663C-$66F7, $688E-$6905):
    //   * after the last byte of a sound, ONE more nibble is decoded: the low nibble of the byte that
    //     follows it (the "pad" byte). The encoder stores a real sample there.
    //   * the next interrupt only holds the output (the next ID is loaded in that interrupt).
    //   * the new sound starts with step = 0 but keeps the predictor of the previous sound.
    // So a split sound of n bytes carries 2n + 1 samples + 1 held sample (= 2n + 2 output samples).

    // Returns parts of (n + 1) bytes each: n data bytes followed by the pad byte. The table length is n.
    public static List<byte[]> EncodeSegments(double[] target, int maxBytes, int lookahead, int searchBytes)
    {
        int total = target.Length;
        var energy = Smooth(target, 32);
        var parts = new List<byte[]>();
        var s = new State();
        int start = 0;
        while (true)
        {
            int remaining = total - start;
            bool last = remaining <= 2 * maxBytes + 1;
            int n;
            if (last)
            {
                n = Math.Max(1, remaining / 2);
            }
            else
            {
                // Put the seam at the quietest place near the end of the part.
                int hi = Math.Min(maxBytes, (remaining - 3) / 2);
                n = hi;
                double best = double.MaxValue;
                for (int c = hi; c >= Math.Max(1, hi - searchBytes); c--)
                {
                    double e = energy[start + 2 * c];
                    if (e < best)
                    {
                        best = e;
                        n = c;
                    }
                }
            }

            var bytes = new byte[n + 1];
            if (parts.Count > 0) s.StepIdx = 0;
            for (int j = 0; j <= 2 * n; j++)
            {
                bool isPad = j == 2 * n;
                int i = start + j;
                double t0 = target[Math.Min(i, total - 1)];
                int nextIndex = isPad ? start + 2 * n + 2 : i + 1;
                bool hasNext = lookahead > 0 && !(isPad && last);
                double t1 = hasNext ? target[Math.Min(nextIndex, total - 1)] : 0;

                int bestNibble = 0;
                double bestErr = double.MaxValue;
                for (int c = 0; c < 16; c++)
                {
                    var s1 = Apply(s, c);
                    double e = (t0 - s1.Pred) * (t0 - s1.Pred);
                    if (hasNext)
                    {
                        var b = s1;
                        if (isPad) b.StepIdx = 0;
                        double e1 = double.MaxValue;
                        for (int m = 0; m < 16; m++)
                        {
                            var s2 = Apply(b, m);
                            e1 = Math.Min(e1, (t1 - s2.Pred) * (t1 - s2.Pred));
                        }
                        e += e1;
                    }
                    if (e < bestErr)
                    {
                        bestErr = e;
                        bestNibble = c;
                    }
                }
                s = Apply(s, bestNibble);
                if ((j & 1) == 0) bytes[j / 2] = (byte)bestNibble;
                else bytes[j / 2] |= (byte)(bestNibble << 4);
            }
            parts.Add(bytes);
            start += 2 * n + 2;
            if (last) break;
        }
        return parts;
    }

    // Models the BIOS playing the parts in order. The output index equals the target index.
    public static sbyte[] DecodeSegments(IList<byte[]> parts)
    {
        var result = new List<sbyte>();
        var s = new State();
        foreach (var bytes in parts)
        {
            s.StepIdx = 0;
            int n = bytes.Length - 1;
            for (int k = 0; k < n; k++)
            {
                s = Apply(s, bytes[k] & 15);
                result.Add((sbyte)s.Pred);
                s = Apply(s, bytes[k] >> 4);
                result.Add((sbyte)s.Pred);
            }
            s = Apply(s, bytes[n] & 15);
            result.Add((sbyte)s.Pred);
            result.Add((sbyte)s.Pred);
        }
        return result.ToArray();
    }

    // Moving average of |x| over +-radius samples.
    static double[] Smooth(double[] x, int radius)
    {
        var prefix = new double[x.Length + 1];
        for (int i = 0; i < x.Length; i++) prefix[i + 1] = prefix[i] + Math.Abs(x[i]);
        var y = new double[x.Length];
        for (int i = 0; i < x.Length; i++)
        {
            int a = Math.Max(0, i - radius), b = Math.Min(x.Length, i + radius + 1);
            y[i] = (prefix[b] - prefix[a]) / (b - a);
        }
        return y;
    }
}

public static class GkAudio
{
    // Reads a PCM/float WAV and returns mono samples in -1..1 together with the sample rate.
    public static double[] ReadWav(string path, out double rate)
    {
        using var r = new BinaryReader(File.OpenRead(path));
        if (new string(r.ReadChars(4)) != "RIFF") throw new InvalidDataException(path + ": not a RIFF file");
        r.ReadUInt32();
        if (new string(r.ReadChars(4)) != "WAVE") throw new InvalidDataException(path + ": not a WAVE file");

        int format = 0, channels = 0, bits = 0;
        rate = 0;
        byte[] raw = null;
        while (r.BaseStream.Position + 8 <= r.BaseStream.Length)
        {
            string id = new string(r.ReadChars(4));
            uint size = r.ReadUInt32();
            long next = r.BaseStream.Position + size + (size & 1);
            if (id == "fmt ")
            {
                format = r.ReadUInt16();
                channels = r.ReadUInt16();
                rate = r.ReadUInt32();
                r.ReadUInt32();
                r.ReadUInt16();
                bits = r.ReadUInt16();
                if (format == 0xFFFE && size >= 26)
                {
                    r.ReadUInt16();
                    r.ReadUInt16();
                    r.ReadUInt32();
                    format = r.ReadUInt16();
                }
            }
            else if (id == "data")
            {
                raw = r.ReadBytes((int)Math.Min(size, r.BaseStream.Length - r.BaseStream.Position));
            }
            r.BaseStream.Position = Math.Min(next, r.BaseStream.Length);
        }
        if (raw == null || channels == 0) throw new InvalidDataException(path + ": no fmt/data chunk");
        if (!(format == 1 && (bits == 8 || bits == 16 || bits == 24 || bits == 32)) && !(format == 3 && (bits == 32 || bits == 64)))
            throw new NotSupportedException($"{path}: unsupported WAV format (tag {format}, {bits} bit)");

        int bytes = bits / 8;
        int frames = raw.Length / (bytes * channels);
        var mono = new double[frames];
        for (int i = 0; i < frames; i++)
        {
            double sum = 0;
            for (int c = 0; c < channels; c++)
            {
                int p = (i * channels + c) * bytes;
                double v;
                if (format == 3) v = bits == 32 ? BitConverter.ToSingle(raw, p) : BitConverter.ToDouble(raw, p);
                else if (bits == 8) v = (raw[p] - 128) / 128.0;
                else if (bits == 16) v = BitConverter.ToInt16(raw, p) / 32768.0;
                else if (bits == 24) v = ((raw[p] << 8 | raw[p + 1] << 16 | raw[p + 2] << 24) >> 8) / 8388608.0;
                else v = BitConverter.ToInt32(raw, p) / 2147483648.0;
                sum += v;
            }
            mono[i] = sum / channels;
        }
        return mono;
    }

    public static void WriteWav16(string path, double[] samples, int rate)
    {
        using var w = new BinaryWriter(File.Create(path));
        int dataSize = samples.Length * 2;
        w.Write(new[] { 'R', 'I', 'F', 'F' });
        w.Write(36 + dataSize);
        w.Write(new[] { 'W', 'A', 'V', 'E', 'f', 'm', 't', ' ' });
        w.Write(16);
        w.Write((short)1);
        w.Write((short)1);
        w.Write(rate);
        w.Write(rate * 2);
        w.Write((short)2);
        w.Write((short)16);
        w.Write(new[] { 'd', 'a', 't', 'a' });
        w.Write(dataSize);
        foreach (var v in samples)
            w.Write((short)Math.Max(-32768, Math.Min(32767, Math.Round(v * 32767))));
    }

    // Windowed-sinc resampler. The low-pass cutoff follows the lower of the two rates.
    public static double[] Resample(double[] x, double srcRate, double dstRate)
    {
        if (Math.Abs(srcRate - dstRate) < 1e-6) return (double[])x.Clone();
        int outLen = (int)Math.Floor(x.Length * dstRate / srcRate);
        var y = new double[outLen];
        double cutoff = 0.45 * Math.Min(srcRate, dstRate) / srcRate; // cycles per input sample
        const int zeroCrossings = 12;
        double half = zeroCrossings / (2 * cutoff);
        for (int n = 0; n < outLen; n++)
        {
            double t = n * srcRate / dstRate;
            int lo = (int)Math.Ceiling(t - half);
            int hi = (int)Math.Floor(t + half);
            double acc = 0, norm = 0;
            for (int k = lo; k <= hi; k++)
            {
                double tau = k - t;
                double a = 2 * Math.PI * cutoff * tau;
                double sinc = Math.Abs(a) < 1e-9 ? 1 : Math.Sin(a) / a;
                double window = 0.5 + 0.5 * Math.Cos(Math.PI * tau / half);
                double h = sinc * window;
                norm += h;
                if (k >= 0 && k < x.Length) acc += h * x[k];
            }
            y[n] = norm != 0 ? acc / norm : 0;
        }
        return y;
    }
}

public class SoundOptions
{
    public int RateNo = 5;          // 0..6, 5 is the BIOS default (about 7812 Hz)
    public bool Normalize = true;   // scale the peak to 0.95 of full scale
    public double GainDb = 0;       // extra gain applied after normalizing
    public double FadeMs = 5;       // fade-out so that the BIOS predictor ends near 0
    public int Lookahead = 1;
    public int MaxBytes = 0xFFFF;   // longest sound the BIOS accepts; longer audio is split
    public double SeamMs = 300;     // how far back from the limit a split may move to find a quiet place
}

public class EncodedSound
{
    public byte[] Data;             // BIOS ADPCM bytes (two samples per byte); null when split
    public List<byte[]> Parts;      // when split: n data bytes + 1 pad byte per part (table length = n)
    public double[] Preview;        // what the BIOS will play, -1..1
    public double Rate;
    public double SnrDb;
}

public static class GkEncoder
{
    public static EncodedSound EncodeWav(string path, SoundOptions o)
    {
        var src = GkAudio.ReadWav(path, out double srcRate);
        double rate = GkAdpcm.SampleRate(o.RateNo);
        var x = GkAudio.Resample(src, srcRate, rate);
        if (x.Length == 0) throw new InvalidDataException(path + ": no samples after resampling");

        double peak = 0;
        foreach (var v in x) peak = Math.Max(peak, Math.Abs(v));
        double gain = Math.Pow(10, o.GainDb / 20) * (o.Normalize && peak > 0 ? 0.95 / peak : 1);

        var target = new double[x.Length];
        for (int i = 0; i < x.Length; i++)
            target[i] = Math.Max(-128, Math.Min(127, x[i] * gain * 127));

        int fade = (int)Math.Min(target.Length, Math.Round(o.FadeMs / 1000 * rate));
        for (int i = 0; i < fade; i++)
            target[target.Length - 1 - i] *= (i + 0.5) / fade;

        // A sound holds at most MaxBytes bytes; longer audio is split into Parts.
        byte[] data = null;
        List<byte[]> parts = null;
        sbyte[] decoded;
        if (target.Length <= 2 * o.MaxBytes)
        {
            data = GkAdpcm.Encode(target, o.Lookahead);
            decoded = GkAdpcm.Decode(data);
        }
        else
        {
            int searchBytes = (int)Math.Round(o.SeamMs / 1000 * rate / 2);
            parts = GkAdpcm.EncodeSegments(target, o.MaxBytes, o.Lookahead, searchBytes);
            decoded = GkAdpcm.DecodeSegments(parts);
        }

        double sig = 0, err = 0;
        for (int i = 0; i < target.Length; i++)
        {
            sig += target[i] * target[i];
            err += (target[i] - decoded[i]) * (target[i] - decoded[i]);
        }
        var preview = new double[decoded.Length];
        for (int i = 0; i < preview.Length; i++) preview[i] = decoded[i] / 127.0;
        return new EncodedSound
        {
            Data = data,
            Parts = parts,
            Preview = preview,
            Rate = rate,
            SnrDb = err > 0 ? 10 * Math.Log10(sig / err) : double.PositiveInfinity
        };
    }
}
