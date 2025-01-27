using System;
int address;

using (var reader = new StreamReader(new FileStream("EndAddress.txt", FileMode.Open, FileAccess.Read)))
{
    address = int.Parse(reader.ReadLine());
}

using (var stream = new FileStream("loader.bin", FileMode.Create, FileAccess.Write))
{
    void WriteWord(int w)
    {
        var h = (byte)(w >> 8);
        var l = (byte)(w & 0xff);
        stream.WriteByte(h);
        stream.WriteByte(l);
    }

    void WriteBytes(params byte[] bytes)
    {
        foreach(var b in bytes) {
            stream.WriteByte(b);
        }
    }

    void WriteString(string s) 
    {
        WriteBytes(Encoding.ASCII.GetBytes(s.ToUpper()));
    }

    stream.WriteByte(0xff);
    WriteWord(0x19);

    WriteWord(0x1018);
    WriteWord(10);
    stream.WriteByte(0xcd);
    WriteString("&H");
    WriteString(string.Format("{0:X4}", address));
    stream.WriteByte(0x00);

    WriteWord(0x1023);
    WriteWord(20);
    stream.WriteByte(0xac);
    WriteString("\"\",,R");
    stream.WriteByte(0x00);

    WriteWord(0);
    WriteBytes(0x1b,0x1a);
}
