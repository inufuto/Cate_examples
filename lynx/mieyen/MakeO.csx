var name = Args[0];
var begin = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name + ".o", FileMode.Create, FileAccess.Write))
{
    void WriteBytes(params byte[] bytes)
    {
        foreach (var b in bytes)
        {
            stream.WriteByte(b);
        }
    }
    void WriteWord(int w)
    {
        var l = (byte)(w & 0xff);
        var h = (byte)(w >> 8);
        stream.WriteByte(h);
        stream.WriteByte(l);
    }
    WriteBytes(0x80, 0x08);
    WriteWord(begin);
    WriteWord(size + 10);
    WriteBytes(0x42, 0x53, 0x39, 0x33);
    stream.Write(bytes, 0, size);
}