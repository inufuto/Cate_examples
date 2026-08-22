const int rate = 48000;
const short range = 0x7fff;
const int highWaveSamples = rate / 2400;
const int lowWaveSamples = 35;

byte LowByte(ushort v) => (byte)(v & 0xff);
byte HighByte(ushort v) => (byte)(v >> 8);

short[] MakeSyntheticWave(int samples)
{
    var wave = new short[samples];
    for (var i = 0; i < wave.Length / 2; ++i) {
        wave[i] = range;
    }
    for (var i = wave.Length / 2; i < wave.Length; ++i) {
        wave[i] = (short)-range;
    }
    return wave;
}

var lowWave = MakeSyntheticWave(lowWaveSamples);
var highWave = MakeSyntheticWave(highWaveSamples);
var samples = new List<short>();

void AddWave(short[] wave, int count)
{
    for (var i = 0; i < count; ++i) {
        samples.AddRange(wave);
    }
}

void AddByte(byte b)
{
    AddWave(highWave, 1);
    var bit = 0x01;
    var oneCount = 0;
    for (int i = 0; i < 8; ++i) {
        if ((b & bit) == 0) {
            AddWave(highWave, 1);
        } else {
            AddWave(lowWave, 1);
            ++oneCount;
        }
        bit <<= 1;
    }
    AddWave((oneCount & 1) == 0 ? highWave : lowWave, 1);
    AddWave(lowWave, 2);
}

void AddBlock(byte recordType, List<byte> bytes, int preToneLength)
{
    AddWave(lowWave, preToneLength);
    AddByte(0xee);
    AddByte(0xee);
    AddByte(HighByte((ushort)bytes.Count));
    AddByte(LowByte((ushort)bytes.Count));
    AddByte(recordType);
    foreach (var b in bytes) {
        AddByte(b);
    }
    AddWave(lowWave, 0x04B0);
}

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

{
    var headBlock = new List<byte>();
    headBlock.Add(0x4f);
    headBlock.Add(LowByte((ushort)address));
    headBlock.Add(HighByte((ushort)address));

    var bs = Encoding.ASCII.GetBytes(name.ToUpper() + "\n");
    var count = 0;
    var i = 0;
    while (i < bs.Length && count < 80 - 3) {
        headBlock.Add(bs[i++]);
        ++count;
    }
    while (count < 80 - 3) {
        headBlock.Add(0x20);
        ++count;
    }
    AddBlock(0x48, headBlock, 0x2EE0);
}
{
    var bytes = new byte[0x10000];
    var size = 0;
    using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
    {
        size = stream.Read(bytes);
    }
    var bodyBlock = new List<byte>(bytes.Take(size));
    AddBlock(0x44, bodyBlock, 0x0BB8);
}

void WriteWordL(Stream stream, ushort value)
{
    stream.WriteByte((byte)(value & 0xff));
    stream.WriteByte((byte)(value >> 8));
}

void WriteDWordL(Stream stream, uint value)
{
    WriteWordL(stream, (ushort)(value & 0xffff));
    WriteWordL(stream, (ushort)(value >> 16));
}

static void WriteString(Stream stream, string s, int size)
{
    var bytes = Encoding.ASCII.GetBytes(s);
    var i = 0;
    foreach (var b in bytes) {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size) {
        stream.WriteByte(0x20);
        ++i;
    }
}

using (var stream = new FileStream(name + ".wav", FileMode.Create, FileAccess.Write)) {
    WriteString(stream, "RIFF", 4);
    WriteDWordL(stream, (uint)(36 + samples.Count * 2));
    WriteString(stream, "WAVE", 4);
    WriteString(stream, "fmt", 4);
    WriteDWordL(stream, 16);
    WriteWordL(stream, 1);
    WriteWordL(stream, 1);
    WriteDWordL(stream, rate);
    WriteDWordL(stream, rate * 2);
    WriteWordL(stream, 2);
    WriteWordL(stream, 16);
    WriteString(stream, "data", 4);
    WriteDWordL(stream, (uint)(samples.Count * 2));
    foreach (var value in samples) {
        WriteWordL(stream, (ushort)value);
    }
}



