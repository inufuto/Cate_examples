var name = Args[0];
var address = Convert.ToInt32(Args[1], 16);

var bin = new byte[0x10000];
var binSize = 0;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}

var gfx = new byte[0x10000];
var gfxSize = 0;
using (var stream = new FileStream(name + ".gfx", FileMode.Open, FileAccess.Read))
{
    gfxSize = stream.Read(gfx);
}

using (var stream = new FileStream(name + ".neo", FileMode.Create, FileAccess.Write)) {
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

    stream.WriteByte(3);
    WriteString("NEO");    
    WriteBytes(0,0);
    WriteWord(address);
    
    stream.WriteByte(0x80);
    WriteWord(address);
    WriteWord(binSize);
    WriteString(name);
    stream.WriteByte(0);
    stream.Write(bin, 0, binSize);

    stream.WriteByte(0x00);
    WriteWord(0xffff);
    WriteWord(gfxSize);
    stream.WriteByte(0);
    stream.Write(gfx, 0, gfxSize);
}
