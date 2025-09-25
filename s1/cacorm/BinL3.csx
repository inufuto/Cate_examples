private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)(value >> 8));
    stream.WriteByte((byte)value);
}

private static void WriteBytes(FileStream stream, byte value, int count)
{
    for (var i = 0; i < count; ++i)
    {
        stream.WriteByte(value);
    }
}

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name+".bin", FileMode.Open, FileAccess.Read)) {
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name+"_02.l3",FileMode.Create, FileAccess.Write)) {
    WriteBytes(stream, 0xc9,20);
    WriteWord(stream, (ushort)address);
    WriteWord(stream, (ushort)size);
    stream.Write(bytes, 0, size);
}
