// Converts a WAV file to GameKing BIOS ADPCM.
//
// usage: dotnet script EncodeWav.csx <in.wav> <out.adp> [options]
//   -r <0..6>       sample rate number (BIOS function $44 argument). default 5 = 7812 Hz
//                     0:2930 1:3348 2:3906 3:4687 4:5859 5:7812 6:11719 Hz
//   --preview <wav> write the decoded result (what the BIOS plays) as a WAV
//   --no-normalize  do not scale the peak to 0.95
//   --gain <dB>     extra gain
//   --fade <ms>     fade-out length (default 5, 0 = off)
//   --lookahead <0|1>
#load "Adpcm.csx"

using System;
using System.IO;
using System.Globalization;

if (Args.Count < 2)
{
    Console.WriteLine("usage: dotnet script EncodeWav.csx <in.wav> <out.adp> [-r 0..6] [--preview x.wav] [--no-normalize] [--gain dB] [--fade ms] [--lookahead 0|1]");
    return;
}

var input = Args[0];
var output = Args[1];
var options = new SoundOptions();
string preview = null;
for (int i = 2; i < Args.Count; i++)
{
    switch (Args[i])
    {
        case "-r": options.RateNo = int.Parse(Args[++i]); break;
        case "--preview": preview = Args[++i]; break;
        case "--no-normalize": options.Normalize = false; break;
        case "--gain": options.GainDb = double.Parse(Args[++i], CultureInfo.InvariantCulture); break;
        case "--fade": options.FadeMs = double.Parse(Args[++i], CultureInfo.InvariantCulture); break;
        case "--lookahead": options.Lookahead = int.Parse(Args[++i]); break;
        default: throw new ArgumentException("unknown option " + Args[i]);
    }
}

var encoded = GkEncoder.EncodeWav(input, options);
if (encoded.Data.Length > 0xFFFF)
    throw new InvalidOperationException($"{encoded.Data.Length} bytes: a sound can be at most 65535 bytes (BIOS length is 16 bit)");

File.WriteAllBytes(output, encoded.Data);
if (preview != null)
    GkAudio.WriteWav16(preview, encoded.Preview, (int)Math.Round(encoded.Rate));

Console.WriteLine($"{Path.GetFileName(input)} -> {Path.GetFileName(output)}: {encoded.Data.Length} bytes, " +
    $"{encoded.Preview.Length / encoded.Rate:F2} s @ {encoded.Rate:F0} Hz (rate no. {options.RateNo}), SNR {encoded.SnrDb:F1} dB");
