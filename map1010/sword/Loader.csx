const int RecLen = 32;

var loaderAddress = int.Parse(Args[0], System.Globalization.NumberStyles.AllowHexSpecifier);

var loader = new byte[0x8000];
int loaderSize;

using (var stream = new FileStream("loader.bin", FileMode.Open, FileAccess.Read))
{
    loaderSize = stream.Read(loader);
}

using (var writer = new StreamWriter("loader.txt", false, Encoding.UTF8))
{
    var lineNum = 10;
    // writer.WriteLine($"{lineNum} CLEAR100,&H{loaderAddress - 1:X4}"); lineNum += 10;
    writer.WriteLine($"{lineNum} A=&H{loaderAddress:X4}"); lineNum += 10;
    var recordCount = (loaderSize + RecLen - 1) / RecLen;
    writer.WriteLine($"{lineNum} FORI=1TO{recordCount}"); lineNum += 10;
    writer.WriteLine($"{lineNum} READL$"); lineNum += 10;
    writer.WriteLine($"{lineNum} FORJ=1TOLEN(L$)STEP2"); lineNum += 10;
    writer.WriteLine($"{lineNum} POKEA,VAL(\"&H\"+MID$(L$,J,2))"); lineNum += 10;
    writer.WriteLine($"{lineNum} A=A+1"); lineNum += 10;
    writer.WriteLine($"{lineNum} NEXT"); lineNum += 10;
    writer.WriteLine($"{lineNum} NEXT"); lineNum += 10;
    for (var i = 0; i < loaderSize; i += RecLen)
    {
        writer.Write($"{lineNum} DATA");
        for (var j = i; j < i + RecLen && j < loaderSize; ++j)
        {
            writer.Write($"{loader[j]:X2}");
        }
        writer.WriteLine(); lineNum += 10;
    }
    writer.WriteLine($"{lineNum} CLS:EXEC&H{loaderAddress:X4}"); lineNum += 10;
}
