private const int FirstAddress = 0x8000;
private const int SecondAddress = 0xe000;
private const int BlockSize = 0x2000;
private const int SourceSize = SecondAddress + BlockSize - FirstAddress;

private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)(value >> 8));
    stream.WriteByte((byte)value);
}

private static void WriteDWord(Stream stream, uint value)
{
    WriteWord(stream, (ushort)(value >> 16));
    WriteWord(stream, (ushort)value);
}

private static void WriteString(Stream stream, string s, int size, byte space = 0)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bytes)
    {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }

    while (i < size)
    {
        stream.WriteByte(space);
        ++i;
    }
}

private static void WriteChip(FileStream stream, byte[] bytes, int address, int bank)
{
    WriteString(stream, "CHIP", 4); // ROM signature
    WriteDWord(stream, (uint)(bytes.Length + 16)); // Total packet length 
    WriteWord(stream, 0); // Chip type
    WriteWord(stream, (ushort)bank); // Bank number
    WriteWord(stream, (ushort)address); // Starting load address
    WriteWord(stream, BlockSize); // ROM image size in bytes
    stream.Write(bytes);
}

private static void WriteBytes(FileStream stream, byte value, int count)
{
    for (var i = 0; i < count; ++i)
    {
        stream.WriteByte(value);
    }
}

private static byte[] PartBytes(byte[] sourceBytes, int index)
{
    var chipBytes = new byte[BlockSize];
    Array.Copy(sourceBytes, index, chipBytes, 0, chipBytes.Length);
    return chipBytes;
}

var sourceName = Args[0];
var directory = Path.GetDirectoryName(sourceName);
if (string.IsNullOrEmpty(directory))
{
    directory = Directory.GetCurrentDirectory();
}

var baseName = Path.GetFileNameWithoutExtension(sourceName);
if (string.IsNullOrEmpty(baseName))
{
    baseName = "";
}

baseName = directory + Path.DirectorySeparatorChar + baseName;

var sourceBytes = new byte[SourceSize];
using (var stream = new FileStream(directory + Path.DirectorySeparatorChar + sourceName, FileMode.Open,
           FileAccess.Read))
{
    stream.Read(sourceBytes);
}

var lowBytes = PartBytes(sourceBytes, 0);
var highBytes = PartBytes(sourceBytes, SecondAddress - FirstAddress);

using (var stream = new FileStream(baseName + "-8000.bin", FileMode.Create, FileAccess.Write))
{
    stream.Write(lowBytes);
}
using (var stream = new FileStream(baseName + "-e000.bin", FileMode.Create, FileAccess.Write))
{
    stream.Write(highBytes);
}
using (var stream = new FileStream(baseName + "_16k.bin", FileMode.Create, FileAccess.Write))
{
    stream.Write(lowBytes);
    stream.Write(highBytes);
}
using (var stream = new FileStream(baseName + ".crt", FileMode.Create, FileAccess.Write))
{
    WriteString(stream, "C64 CARTRIDGE", 16, 0x20); // cartridge signature
    WriteDWord(stream, 0x40); // File header length
    WriteWord(stream, 0x0100); // Cartridge version
    WriteWord(stream, 0); // Cartridge hardware type
    stream.WriteByte(1); // Cartridge port EXROM line status
    stream.WriteByte(0); // Cartridge port GAME line status
    stream.WriteByte(0); // Cartridge Hardware Revision/Subtype
    WriteBytes(stream, 0, 5); // Reserved
    WriteString(stream, baseName, 32, 0);


    WriteChip(stream, lowBytes, FirstAddress, 1);
    WriteChip(stream, highBytes, SecondAddress, 2);
}
