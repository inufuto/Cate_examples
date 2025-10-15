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

var name = Args[0];

var bytes = new byte[0x4000];
int size;

using (var stream = new FileStream(name+".bin", FileMode.Open, FileAccess.Read)) {
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name+"_02.bin",FileMode.Create, FileAccess.Write)) {
    WriteBytes(stream, 0xc9,10);
    WriteWord(stream, 0x8800);
    WriteWord(stream, (ushort)size);
    stream.Write(bytes, 0, size);
}
