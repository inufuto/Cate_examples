const int RecLen = 120 / 2;

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);
var loaderAddress = int.Parse(Args[2], System.Globalization.NumberStyles.HexNumber);


var loader = new byte[0x100];
int loaderSize;
using (var stream = new FileStream("Loader.bin", FileMode.Open, FileAccess.Read))
{
    loaderSize = stream.Read(loader);
}


var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}


using (var writer = new StreamWriter("Loader.bas", false, Encoding.ASCII))
{
    var line = 10;

    void WriteLine(string s)
    {
        writer.WriteLine($"{line} {s}");
        line += 10;
    }
    {
        WriteLine($"A={loaderAddress}");
        WriteLine("READL$");
        WriteLine("FORJ=1TOLEN(L$)STEP2");
        WriteLine("POKEA,VAL(\"&H\"+MID$(L$,J,2))");
        WriteLine("A=A+1");
        WriteLine("NEXT");

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
        WriteLine("OPEN\"COM0:\"FORINPUTAS#1");
        WriteLine("PRINT\"WAITING\"");
        WriteLine("INPUT#1,F$,A,E,X");
        WriteLine("PRINTF$,HEX$(A);\"-\";HEX$(E)");
        var loopLine = line;
        WriteLine("INPUT#1,L$,S");
        WriteLine("PRINT\".\";");
        WriteLine("FORJ=1TOLEN(L$)STEP48");
        WriteLine("DEFCHR$(252)=MID$(L$,J,12)");
        WriteLine("DEFCHR$(253)=MID$(L$,J+12,12)");
        WriteLine("DEFCHR$(254)=MID$(L$,J+24,12)");
        WriteLine("DEFCHR$(255)=MID$(L$,J+36,12)");
        WriteLine($"MODE110({loaderAddress})");
        WriteLine("A=A+24");
        WriteLine("NEXT");
        WriteLine($"IFA<{address+binSize}THENGOTO{loopLine}");
        WriteLine("CLOSE:BEEP1");
        WriteLine("STOP");
        WriteLine($"MODE110({address})");
    }
}
