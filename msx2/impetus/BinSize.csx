using System;
using System.Globalization;

var name = Args[0];
var start = Args[1];

int BinSize(string fileName)
{
    var min = int.MaxValue;
    var max = int.MinValue;

    using (var reader = new StreamReader(fileName, Encoding.UTF8))
    {
        var line = reader.ReadLine();
        while (line != null)
        {
            if (line.Length >= 14 && line.Substring(1, 3) == "SEG")
            {
                var top = int.Parse(line.Substring(5, 4), NumberStyles.HexNumber);
                var tail = int.Parse(line.Substring(10, 4), NumberStyles.HexNumber);
                min = Math.Min(min, top);
                max = Math.Max(max, tail);
            }
            line = reader.ReadLine();
        }
    }
    return max - min + 1;
}

var size1 = BinSize(name + "1.symbols.txt");
var size2 = BinSize(name + "2.symbols.txt");

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine("BinStart equ " + start + "h");
    writer.WriteLine("BinSize1 equ " + size1);
    writer.WriteLine("BinSize2 equ " + size2);
}
