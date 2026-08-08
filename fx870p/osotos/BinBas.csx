const int RecLen = 6 * 4 * 2;
const int MaxBlockSize = RecLen * 90;

var loader = new byte[0x8000];
int loaderSize;
using (var stream = new FileStream("Loader.bin", FileMode.Open, FileAccess.Read))
{
    loaderSize = stream.Read(loader);
}


var name = Args[0];
var startAddress = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);
var loaderAddress = Args[2];

var address = startAddress;
var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}
int binIndex = 0;

var blockCount = (binSize + MaxBlockSize - 1) / MaxBlockSize;
for (var blockIndex = 0; blockIndex < blockCount; ++blockIndex)
{
    var blockSize = Math.Min(binSize - binIndex, MaxBlockSize);
    var basicName = (blockCount > 1 ? name + "_" + (blockIndex + 1) : name) + ".bas";
    using (var writer = new StreamWriter(basicName, false, Encoding.ASCII))
    {
        var line = 10;
        void WriteLine(string s)
        {
            writer.WriteLine($"{line} {s}");
            line += 10;
        }

        if (blockIndex == 0)
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
            var recordCount = (blockSize + RecLen - 1) / RecLen;
            WriteLine($"A=&H{address:X4}");
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
            if (blockIndex == blockCount - 1)
            {
                WriteLine($"MODE110(&H{startAddress:X4})");
            }

            for (var i = 0; i < blockSize && binIndex < binSize; i += RecLen)
            {
                var s = "DATA ";
                for (var j = 0; j < RecLen && binIndex < binSize; ++j)
                {
                    s += $"{bin[binIndex++]:X2}";
                    ++address;
                }
                WriteLine(s);
            }
        }
    }
}