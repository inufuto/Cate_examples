const int RecLen = 32;
const int MaxBlockSize = RecLen * 128;

var loaderAddress = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);


var loader = new byte[0x8000];
int loaderSize;
using (var stream = new FileStream("Loader.bin", FileMode.Open, FileAccess.Read))
{
    loaderSize = stream.Read(loader);
}

using (var stream = new FileStream("loader.cmt", FileMode.Create, FileAccess.Write))
{
    void WriteBytesR(byte b, int count)
    {
        for (var i = 0; i < count; ++i)
        {
            stream.WriteByte(b);
        }
    }
    void WriteWord(int w)
    {
        var h = (byte)(w >> 8);
        var l = (byte)(w & 0xff);
        stream.WriteByte(l);
        stream.WriteByte(h);
    }
    void WriteString(string s)
    {
        var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
        stream.Write(bytes);
    }
    void WriteStringZ(string s, int size)
    {
        var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
        var i = 0;
        foreach (var b in bytes)
        {
            if (i >= size) break;
            stream.WriteByte(b);
            ++i;
        }
        while (i < size)
        {
            stream.WriteByte(0);
            ++i;
        }
    }

    var lineNum = 10;
    void WriteLineNum()
    {
        WriteWord(1);
        WriteWord(lineNum);
        lineNum += 10;
    }

    WriteBytesR(0xd3, 10);
    WriteStringZ("LOADER", 6);
    {
        WriteLineNum();
        stream.WriteByte(0xa3); // CLEAR
        WriteString($"200,&H{loaderAddress - 1:X4}");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x94); // DEFINT
        WriteString("A");
        stream.WriteByte(0xd2); // -
        WriteString("Z");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        WriteString("A");
        stream.WriteByte(0xdd); // =
        WriteString($" {loaderAddress}");
        stream.WriteByte(0x00);
    }
    var recordCount = (loaderSize + RecLen - 1) / RecLen;
    {
        WriteLineNum();
        stream.WriteByte(0x81); // FOR
        WriteString("I");
        stream.WriteByte(0xdd); // =
        WriteString("1");
        stream.WriteByte(0xbb); // TO
        WriteString($"{recordCount}");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x86); // READ
        WriteString("L$");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x81); // FOR
        WriteString("J");
        stream.WriteByte(0xdd); // =
        WriteString("1");
        stream.WriteByte(0xbb); // TO
        stream.WriteByte(0xf1); // LEN
        WriteString("(L$)");
        stream.WriteByte(0xd0); // STEP
        WriteString("2");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x9e); // POKE
        WriteString("A,");
        stream.WriteByte(0xf4); // VAL
        WriteString("(\"&H\"");
        stream.WriteByte(0xd1); // +
        stream.WriteByte(0xfa); // MID$
        WriteString("(L$,J,2))");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        WriteString("A");
        stream.WriteByte(0xdd); // =
        WriteString("A");
        stream.WriteByte(0xd1); // +
        WriteString("1");
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x82); // NEXT
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0x82); // NEXT
        stream.WriteByte(0x00);
    }
    for (var i = 0; i < loaderSize; i += RecLen)
    {
        WriteLineNum();
        stream.WriteByte(0x83); // DATA
        for (var j = i; j < i + RecLen && j < loaderSize; ++j)
        {
            WriteString($"{loader[j]:X2}");
        }
        stream.WriteByte(0x00);
    }
    {
        WriteLineNum();
        stream.WriteByte(0xA6); // CLS
        WriteString(":");
        stream.WriteByte(0xA8); // EXEC
        WriteString($"&H{loaderAddress:X4}");
        stream.WriteByte(0x00);
    }
    WriteBytesR(0, 12);
}
