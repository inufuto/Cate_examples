const int RowSize = 16;

private static void WriteBytes(FileStream stream, byte value, int count)
{
    for (var i = 0; i < count; ++i)
    {
        stream.WriteByte(value);
    }
}

private static void WriteString(FileStream stream, string s)
{
    var bytes = Encoding.ASCII.GetBytes(s);
    foreach (var b in bytes)
    {
        stream.WriteByte(b);
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

var rowCount = (size + RowSize - 1) / RowSize;

using (var stream = new FileStream(name + ".p6", FileMode.Create, FileAccess.Write))
{
    WriteBytes(stream, 0x9c, 6);
    var offset = 0;
    for (var row = 0; row < rowCount; ++row)
    {
        stream.WriteByte(0x0d);
        stream.WriteByte(0x0a);
        WriteString(stream, ":10");
        WriteString(stream, string.Format("{0:X4}", address));
        WriteString(stream, "00");
        var sum = 0x10 + (address >> 8) + (address & 0xff);
        for (var i = 0; i < RowSize; ++i)
        {
            var b = bytes[offset++];
            sum += b;
            WriteString(stream, string.Format("{0:X2}", b));
            ++address;
        }
        WriteString(stream, string.Format("{0:X2}", -sum & 0xff));
    }
    stream.WriteByte(0x0d);
    stream.WriteByte(0x0a);
    WriteString(stream, ":0000000000000000");

    stream.WriteByte(0x1a);
    // WriteBytes(stream, 0x00, 16);
}
