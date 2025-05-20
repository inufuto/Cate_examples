using System.Globalization;

private const int FirstAddress = 0x2000;
private const int SecondAddress = 0xa000;
private const int BlockSize = 0x2000;
private const int SourceSize = SecondAddress + BlockSize - FirstAddress;

private static void WriteBytes(string baseName, byte[] sourceBytes, int address, int size)
{
    using (var stream = new FileStream($"{baseName}-{address:x}.rom", FileMode.Create, FileAccess.Write))
    {
        stream.Write(sourceBytes, address - FirstAddress, size);
    }
    using (var stream = new FileStream($"{baseName}-{address:x}.prg", FileMode.Create, FileAccess.Write))
    {
        stream.WriteByte((byte)(address & 0xff));
        stream.WriteByte((byte)(address >> 8));
        stream.Write(sourceBytes, address - FirstAddress, size);
    }
}

var sourceName = Args[0];
var directory = Path.GetDirectoryName(sourceName);
if (string.IsNullOrEmpty(directory))
{
    directory = Directory.GetCurrentDirectory();
}

var secondSize = 0x2000;

if (Args.Count >= 2 && int.TryParse(Args[1], NumberStyles.AllowHexSpecifier, null, out secondSize)) {
}


var sourceBytes = new byte[SourceSize];
using (var stream = new FileStream(directory + Path.DirectorySeparatorChar + sourceName, FileMode.Open, FileAccess.Read))
{
    stream.Read(sourceBytes);
}

var baseName = Path.GetFileNameWithoutExtension(sourceName);
if (string.IsNullOrEmpty(baseName))
{
    baseName = "";
}
baseName = directory + Path.DirectorySeparatorChar + baseName;
for (var address = FirstAddress; address < FirstAddress + secondSize; address += BlockSize)
{
    WriteBytes(baseName, sourceBytes, address, BlockSize);
}
WriteBytes(baseName, sourceBytes, SecondAddress, BlockSize);

var lowRomBytes = new byte[0x8000];
var highRomBytes = new byte[0x8000];
for (var i = 0; i < 0x2000; ++i)
{
    lowRomBytes[0x6000 + i] = sourceBytes[i];
    lowRomBytes[0x4000 + i] = sourceBytes[i + 0x2000];
    highRomBytes[0x6000 + i] = sourceBytes[i + 0x8000];
}
using (var stream = new FileStream($"{baseName}_low.rom", FileMode.Create, FileAccess.Write))
{
    stream.Write(lowRomBytes);
}
using (var stream = new FileStream($"{baseName}_high.rom", FileMode.Create, FileAccess.Write))
{
    stream.Write(highRomBytes);
}
using (var stream = new FileStream($"{baseName}_32k.rom", FileMode.Create, FileAccess.Write))
{
    stream.Write(sourceBytes, 0x8000,0x2000);
    stream.Write(sourceBytes, 0x0000,0x6000);
}
