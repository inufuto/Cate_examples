const int RecLen = 6 * 4 * 2;

var loader = new byte[0x8000];
int loaderSize;
using (var stream = new FileStream("Loader.bin", FileMode.Open, FileAccess.Read))
{
    loaderSize = stream.Read(loader);
}


var name = Args[0];
var address = Args[1];
var loaderAddress = Args[2];

var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}


using (var writer = new StreamWriter(name + ".bas", false, Encoding.ASCII))
{
    var line = 10;

    void WriteLine(string s)
    {
        writer.WriteLine($"{line} {s}");
        line += 10;
    }
    {
        var recordCount = (loaderSize + RecLen - 1) / RecLen;
        WriteLine($"A=&H{loaderAddress}");
        WriteLine($"FORI=1TO{recordCount}");
        WriteLine($"READL$");
        WriteLine($"FORJ=1TOLEN(L$)STEP2");
        WriteLine($"POKEA,VAL(\"&H\"+MID$(L$,J,2))");
        WriteLine($"A=A+1");
        WriteLine($"NEXT");
        WriteLine($"NEXT");

        for (var i = 0; i < loaderSize; i += RecLen)
        {
            var s = "DATA ";
            for (var j = i; j < i + RecLen && j < loaderSize; ++j)
            {
                s += $"{loader[j]:X2}";
            }
            WriteLine(s);
        }
    }
    {
        var recordCount = (binSize + RecLen - 1) / RecLen;
        WriteLine($"A=&H{address}");
        WriteLine($"FORI=1TO{recordCount}");
        WriteLine($"PRINTHEX$(A)");
        WriteLine($"READL$");
        WriteLine($"FORJ=1TOLEN(L$)STEP48");
        WriteLine($"DEFCHR$(252)=MID$(L$,J,12)");
        WriteLine($"DEFCHR$(253)=MID$(L$,J+12,12)");
        WriteLine($"DEFCHR$(254)=MID$(L$,J+24,12)");
        WriteLine($"DEFCHR$(255)=MID$(L$,J+36,12)");
        WriteLine($"MODE110(&H{loaderAddress})");
        WriteLine($"A=A+24");
        WriteLine($"NEXT");
        WriteLine($"NEXT");
        WriteLine($"MODE110(&H{address})");

        for (var i = 0; i < binSize; i += RecLen)
        {
            var s = "DATA ";
            for (var j = i; j < i + RecLen && j < binSize; ++j)
            {
                s += $"{bin[j]:X2}";
            }
            WriteLine(s);
        }

        // WriteLine($"CLS:MODE110(&H{address}")");
    }
}
