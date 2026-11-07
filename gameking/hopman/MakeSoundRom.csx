// Appends GameKing BIOS sounds to a ROM image and patches the cartridge header.
//
// usage: dotnet script MakeSoundRom.csx <rom.bin> <out.bin> [options] <sound.wav|sound.adp>...
//   -r <0..6>       rate number for .wav inputs (default 5 = 7812 Hz); the same number must be
//                   passed to BIOS function $44 at run time
//   --at <hex>      file offset of the sound table (default: end of the ROM image).
//                   An existing region must be blank (all $00 or all $FF). The table (6 bytes per
//                   sound) must not cross a 32 KB bank boundary; the sound data may.
//   --inc <file>    write "Sound_<name> equ <id>" definitions for the assembler
//   --no-normalize, --gain <dB>, --fade <ms>, --lookahead <0|1>   see EncodeWav.csx
//
// Sound IDs are the order of the inputs (0, 1, ...). Layout written to the ROM:
//   table: 6 bytes per sound { ptr lo, ptr hi, bank, len lo, len hi, 0 }
//   data : ADPCM bytes of each sound followed by one $00 byte (the BIOS decodes one extra
//          low nibble after the last byte)
// The table address is stored at ROM offset $50-$52 ({lo, hi, bank}) as read by the BIOS
// sound functions $49-$4B. bank = $80 | (file offset >> 15), ptr = $8000 | (file offset & $7FFF).
#load "Adpcm.csx"

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

const int HeaderPointerOffset = 0x50;

string romPath = null, outPath = null, incPath = null;
int? at = null;
var options = new SoundOptions();
var inputs = new List<string>();
for (int i = 0; i < Args.Count; i++)
{
    switch (Args[i])
    {
        case "-r": options.RateNo = int.Parse(Args[++i]); break;
        case "--at": at = int.Parse(Args[++i], NumberStyles.HexNumber); break;
        case "--inc": incPath = Args[++i]; break;
        case "--no-normalize": options.Normalize = false; break;
        case "--gain": options.GainDb = double.Parse(Args[++i], CultureInfo.InvariantCulture); break;
        case "--fade": options.FadeMs = double.Parse(Args[++i], CultureInfo.InvariantCulture); break;
        case "--lookahead": options.Lookahead = int.Parse(Args[++i]); break;
        default:
            if (Args[i].StartsWith("-")) throw new ArgumentException("unknown option " + Args[i]);
            if (romPath == null) romPath = Args[i];
            else if (outPath == null) outPath = Args[i];
            else inputs.Add(Args[i]);
            break;
    }
}
if (romPath == null || outPath == null || inputs.Count == 0)
{
    Console.WriteLine("usage: dotnet script MakeSoundRom.csx <rom.bin> <out.bin> [-r 0..6] [--at hex] [--inc file] <sound.wav|sound.adp>...");
    return;
}
if (inputs.Count > 254) throw new InvalidOperationException("at most 254 sounds (IDs $00-$FD)");

var rom = File.ReadAllBytes(romPath).ToList();
if (rom.Count < HeaderPointerOffset + 3) throw new InvalidDataException("ROM image is too small");
if (rom[HeaderPointerOffset] != 0 || rom[HeaderPointerOffset + 1] != 0 || rom[HeaderPointerOffset + 2] != 0)
    Console.WriteLine("warning: header bytes $50-$52 are not zero; they will be overwritten");

// Encode everything first.
var sounds = new List<byte[]>();
for (int i = 0; i < inputs.Count; i++)
{
    var path = inputs[i];
    byte[] data;
    if (Path.GetExtension(path).Equals(".adp", StringComparison.OrdinalIgnoreCase))
    {
        data = File.ReadAllBytes(path);
        Console.WriteLine($"id {i,3}: {Path.GetFileName(path)} (raw ADPCM) {data.Length} bytes");
    }
    else
    {
        var e = GkEncoder.EncodeWav(path, options);
        data = e.Data;
        Console.WriteLine($"id {i,3}: {Path.GetFileName(path)} {data.Length} bytes, {e.Preview.Length / e.Rate:F2} s @ {e.Rate:F0} Hz, SNR {e.SnrDb:F1} dB");
    }
    if (data.Length == 0 || data.Length > 0xFFFF)
        throw new InvalidOperationException($"{path}: {data.Length} bytes (must be 1..65535)");
    sounds.Add(data);
}

// Place the table and the data.
int tableOffset = at ?? (rom.Count + 15) / 16 * 16;
int tableSize = sounds.Count * 6;
// The BIOS indexes the table with a 16-bit pointer and does not follow the bank wrap,
// so the table itself must stay inside one 32 KB bank (the sound data may cross banks).
if (tableOffset >> 15 != (tableOffset + tableSize - 1) >> 15)
{
    if (at.HasValue) throw new InvalidOperationException($"the sound table at ${tableOffset:X} crosses a 32 KB bank boundary");
    tableOffset = (tableOffset + 0x7FFF) & ~0x7FFF;
}
int total = tableSize + sounds.Sum(s => s.Length + 1);
int end = tableOffset + total;
if (end > 0x400000) throw new InvalidOperationException("ROM would exceed 4 MB");

int inRom = Math.Max(0, Math.Min(rom.Count, end) - tableOffset);
if (inRom > 0)
{
    var existing = rom.GetRange(tableOffset, inRom);
    if (!(existing.All(b => b == 0x00) || existing.All(b => b == 0xFF)))
        throw new InvalidOperationException($"file offset ${tableOffset:X} - ${tableOffset + inRom - 1:X} is not blank");
}
while (rom.Count < end) rom.Add(0xFF);

byte[] Pointer(int offset) => new[]
{
    (byte)(offset & 0xFF),
    (byte)(0x80 | ((offset >> 8) & 0x7F)),
    (byte)(0x80 | ((offset >> 15) & 0x7F))
};

int cursor = tableOffset + tableSize;
for (int i = 0; i < sounds.Count; i++)
{
    var p = Pointer(cursor);
    int e = tableOffset + i * 6;
    rom[e] = p[0];
    rom[e + 1] = p[1];
    rom[e + 2] = p[2];
    rom[e + 3] = (byte)(sounds[i].Length & 0xFF);
    rom[e + 4] = (byte)(sounds[i].Length >> 8);
    rom[e + 5] = 0;
    for (int k = 0; k < sounds[i].Length; k++) rom[cursor + k] = sounds[i][k];
    rom[cursor + sounds[i].Length] = 0;
    cursor += sounds[i].Length + 1;
}

var header = Pointer(tableOffset);
for (int i = 0; i < 3; i++) rom[HeaderPointerOffset + i] = header[i];

// The BIOS needs a power-of-two sized image.
int size = 0x8000;
while (size < rom.Count) size <<= 1;
while (rom.Count < size) rom.Add(0xFF);
File.WriteAllBytes(outPath, rom.ToArray());

if (incPath != null)
{
    var sb = new StringBuilder();
    sb.AppendLine("; generated by MakeSoundRom.csx");
    sb.AppendLine($"SoundRateNo equ {options.RateNo}");
    var usedNames = new HashSet<string>();
        for (int i = 0; i < inputs.Count; i++)
        {
            var name = new string(Path.GetFileNameWithoutExtension(inputs[i]).Select(c => char.IsLetterOrDigit(c) ? c : '_').ToArray());
            var unique = name;
            for (int n = 2; !usedNames.Add(unique); n++) unique = name + "_" + n;
            sb.AppendLine($"Sound_{unique} equ {i}");
        }
    File.WriteAllText(incPath, sb.ToString());
}

Console.WriteLine($"table at file ${tableOffset:X} (header $50-$52 = {header[0]:X2} {header[1]:X2} {header[2]:X2}), data end ${end:X}, ROM {size / 1024} KB");
