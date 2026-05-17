using System.IO;

const int MaxBlockSize = 256;

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
        stream.WriteByte(0x20);
        ++i;
    }
}


var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name + ".cas", FileMode.Create, FileAccess.Write))
{
    WriteBytes(stream, 0, 256);
    stream.WriteByte(0xa5);
    stream.WriteByte(0x55);
    WriteString(stream, name, 6);

    var offset = 0;
    while (size > 0)
    {
        stream.WriteByte(0x3c);
        var blockSize = Math.Min(MaxBlockSize, size);
        stream.WriteByte((byte)blockSize);
        WriteWord(stream, (ushort)(address + offset));
        var sum = 0;
        for (var i = 0; i < blockSize; ++i)
        {
            var b = bytes[offset++];
            stream.WriteByte(b);
            sum += b;
        }
        stream.WriteByte((byte)-sum);
        size -= blockSize;
    }
    stream.WriteByte(0x78);
    WriteWord(stream, (ushort)(address));
}
