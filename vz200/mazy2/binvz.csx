const int FileType = 0xf0;
const int BasicAddress = 0x7ae9;
const int BinAddress = 0x7b16;


const int Poke = 0xb1;
const int Equal = 0xd5;
const int Usr = 0xc1;

private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)value);
    stream.WriteByte((byte)(value >> 8));
}

private static void WriteBytes(FileStream stream, byte value, int count)
{
    for (var i = 0; i < count; ++i)
    {
        stream.WriteByte(value);
    }
}

private static void WriteString(FileStream stream, string s, int maxSize)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bytes)
    {
        if (i >= maxSize) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < maxSize)
    {
        stream.WriteByte(0);
        ++i;
    }
}

private static void WriteString(FileStream stream, string s)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    foreach (var b in bytes)
    {
        stream.WriteByte(b);
    }
}


var name = Args[0];
var bytes = new byte[0x8000];
int binSize;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bytes);
}

using (var stream = new FileStream(name + ".vz", FileMode.Create, FileAccess.Write))
{
    WriteString(stream, "VZF0");
    WriteString(stream, name, 17);
    stream.WriteByte(FileType);

    int address = BasicAddress;
    WriteWord(stream, (ushort)address);

    address += 14 + 2;
    WriteWord(stream, (ushort)address);
    WriteWord(stream, 10);
    stream.WriteByte(Poke);
    WriteString(stream, " 30862," + string.Format("{0:000}", BinAddress & 0xff));
    stream.WriteByte(0);

    address += 14 + 2;
    WriteWord(stream, (ushort)address);
    WriteWord(stream, 20);
    stream.WriteByte(Poke);
    WriteString(stream, " 30863," + string.Format("{0:000}", BinAddress >> 8));
    stream.WriteByte(0);

    address += 8 + 2;
    WriteWord(stream, (ushort)address);
    WriteWord(stream, 30);
    WriteString(stream, "A");
    stream.WriteByte(Equal);
    stream.WriteByte(Usr);
    WriteString(stream, "(0)");
    stream.WriteByte(0);

    WriteWord(stream, 0);

    for (var i = 0; i < binSize; ++i)
    {
        stream.WriteByte(bytes[i]);
    }
}
