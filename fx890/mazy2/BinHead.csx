using System;

const int Address = 0x2000;

var name = Args[0];

var binBytes = new byte[0x8000];
int binSize;
using (var stream = new FileStream("_raw.bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(binBytes);
}

using (var stream = new FileStream(name + ".bin", FileMode.Create, FileAccess.Write))
{
    void WriteWord(int w)
    {
        var l = (byte)(w & 0xff);
        var h = (byte)(w >> 8);
        stream.WriteByte(l);
        stream.WriteByte(h);
    }
    stream.WriteByte(0xff);
    stream.WriteByte(0xfe);
    stream.WriteByte(0x4d);

    WriteWord(binSize + 16);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);

    WriteWord(Address);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);

    WriteWord(Address);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);

    stream.Write(binBytes, 0, binSize);
}
