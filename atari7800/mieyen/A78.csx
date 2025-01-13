var name = Args[0];

var bin = new byte[0x10000];
var binSize = 0;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}

using (var stream = new FileStream(name + ".a78", FileMode.Create, FileAccess.Write)) {
    void WriteWord(int w)
    {
        var h = (byte)(w >> 8);
        var l = (byte)(w & 0xff);
        stream.WriteByte(l);
        stream.WriteByte(h);
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
    void WriteStringN(string s, int size) 
    {
        var bytes = Encoding.ASCII.GetBytes(s);
        var i = 0;
        foreach (var b in bytes)
        {
            if (i >= size) break;
            stream.WriteByte(b);
            ++i;
        }
        while (i < size)
        {
            stream.WriteByte(0x20);
            ++i;
        }
    }

    stream.WriteByte(4);
    WriteStringN("ATARI7800", 16);
    WriteStringN(name, 32);
    WriteWord(binSize);
    WriteWord(0);
    WriteWord(0);
    stream.WriteByte(1);
    stream.WriteByte(1);
    stream.WriteByte(0);
    stream.WriteByte(0);
    WriteBytes(0,0,0,0);
    stream.WriteByte(0);
    stream.WriteByte(0);
    stream.WriteByte(0);
    WriteWord(0);
    WriteWord(0);
    for (var i=0;i<30;++i) {
        stream.WriteByte(0);
    }
    WriteString("ACTUAL CART DATA STARTS HERE");
    stream.Write(bin, 0, binSize);
}
