const int RecLen = 32;
const int Segment=0x6000;

var name = Args[0];

var bin = new byte[0x10000];

int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    binSize = stream.Read(bin);
}

using (var writer = new StreamWriter("MkBin.bas", false, Encoding.ASCII))
{
    var line = 10;
    var recordCount = (binSize + RecLen - 1) / RecLen;
    writer.WriteLine($"{line} CLEAR ,&H{Segment:x}"); line += 10;
    writer.WriteLine($"{line} DEFINT A-Z"); line += 10;
    writer.WriteLine($"{line} A=0"); line += 10;
    writer.WriteLine($"{line} FOR I=1 TO {recordCount}"); line += 10;
    writer.WriteLine($"{line} IF (A AND 255)=0 THEN PRINT HEX$(A)"); line += 10;
    writer.WriteLine($"{line} READ L$"); line += 10;
    writer.WriteLine($"{line} FOR J=1 TO LEN(L$) STEP 2"); line += 10;
    writer.WriteLine($"{line} POKE A,VAL(\"&H\"+MID$(L$,J,2))"); line += 10;
    writer.WriteLine($"{line} A=A+1"); line += 10;
    writer.WriteLine($"{line} NEXT"); line += 10;
    writer.WriteLine($"{line} NEXT"); line += 10;
    writer.WriteLine($"{line} SAVEM \"{name}.bin\",0,{binSize-1},0"); line += 10;
    // writer.WriteLine($"{line} EXEC 0"); line += 10;
    for (var i = 0; i < binSize; i += RecLen)
    {
        writer.Write($"{line} DATA ");
        for (var j = i; j < i + RecLen && j < binSize; ++j)
        {
            writer.Write($"{bin[j]:X2}");
        }
        writer.WriteLine(); line += 10;
    }
}


using (var writer = new StreamWriter(name + ".bas", false, Encoding.ASCII))
{
    var line = 10;
    writer.WriteLine($"{line} CLEAR ,&H{Segment:x}"); line += 10;
    writer.WriteLine($"{line} LOADM \"{name}.bin\",,R"); line += 10;
}
