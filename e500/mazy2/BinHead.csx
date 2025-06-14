using System;
using System.Globalization;

const int NameSize = 8;

var name = Args[0];

var address = int.Parse(Args[1], NumberStyles.HexNumber);
var maxSize = 0xbfc00 - address;

var binBytes = new byte[0x8000];
int binSize;
using (var stream = new FileStream("_raw.bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(binBytes);
}

string binName = "";
{
    var i = 0;
    foreach (var c in name.ToUpper().ToCharArray())
    {
        if (i > NameSize) break;
        binName += c;
        ++i;
    }
}


using (var stream = new FileStream(binName + ".BIN", FileMode.Create, FileAccess.Write))
{
    void WriteWord(int w)
    {
        var l = (byte)(w & 0xff);
        var h = (byte)(w >> 8);
        stream.WriteByte(l);
        stream.WriteByte(h);
    }
    stream.WriteByte(0xff);
    stream.WriteByte(0x00);
    stream.WriteByte(0x06);
    stream.WriteByte(0x01);
    stream.WriteByte(0x10);

    WriteWord(binSize);
    stream.WriteByte(0x00);

    WriteWord(address);
    stream.WriteByte(0x0b);

    WriteWord(address);
    stream.WriteByte(0x0b);

    stream.WriteByte(0x00);
    stream.WriteByte(0x0f);

    stream.Write(binBytes, 0, binSize);
}

using (var writer = new StreamWriter("CLEAR.BAS", false, Encoding.ASCII))
{
    var line = 10;
    var b1 = maxSize & 0xff;
    var b2 = (maxSize >> 8) & 0xff;
    var b3 = (maxSize >> 16) & 0xff;
    writer.WriteLine($"{line} REM {name.ToUpper()}"); line += 10;
    writer.WriteLine($"{line} POKE&BFE03,&1A,&FD,&B,&{b1:X},&{b2:X},&{b3:X}"); line += 10;
    writer.WriteLine($"{line} CALL&FFFD8"); line += 10;
    writer.Write('\x1a');

    System.Console.WriteLine(maxSize);
}
