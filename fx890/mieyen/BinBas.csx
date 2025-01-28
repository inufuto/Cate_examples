const int RecLen = 32;

var name = Args[0];

var binBytes = new byte[0x8000];
int binSize;
using (var stream = new FileStream("_raw.bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(binBytes);
}


var line = 10;

void WriteBas(StreamWriter writer)
{
    var clearSize = (binSize + 99) / 100 * 100;
    var recordCount = (binSize + RecLen - 1) / RecLen;
    writer.WriteLine($"{line} 'CLEAR 200,{clearSize},{clearSize + 400}"); line += 10;
    writer.WriteLine($"{line} DEFSEG=0"); line += 10;
    writer.WriteLine($"{line} A=&H2000"); line += 10;
    writer.WriteLine($"{line} FORI=1TO{recordCount}"); line += 10;
    writer.WriteLine($"{line} PRINTHEX$(A)"); line += 10;
    writer.WriteLine($"{line} READL$"); line += 10;
    writer.WriteLine($"{line} FORJ=1TOLEN(L$)STEP2"); line += 10;
    writer.WriteLine($"{line} POKEA,VAL(\"&H\"+MID$(L$,J,2))"); line += 10;
    writer.WriteLine($"{line} A=A+1"); line += 10;
    writer.WriteLine($"{line} NEXT"); line += 10;
    writer.WriteLine($"{line} NEXT"); line += 10;

    for (var i = 0; i < binSize; i += RecLen)
    {
        writer.Write($"{line} DATA");
        for (var j = i; j < i + RecLen && j < binSize; ++j)
        {
            writer.Write($"{binBytes[j]:X2}");
        }
        writer.WriteLine(); line += 10;
    }
}

using (var writer = new StreamWriter(name + ".bas", false, Encoding.ASCII))
{
    line = 10;
    WriteBas(writer);
    writer.WriteLine($"{line} CLS:CALL&H2000"); line += 10;
}
