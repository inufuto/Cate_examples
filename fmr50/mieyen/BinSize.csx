using System;
using System.Globalization;

var name = Args[0];

var min = int.MaxValue;
var max = int.MinValue;

using (var reader = new StreamReader(name + ".symbols.txt", Encoding.UTF8))
{
    var line = reader.ReadLine();
    while (line != null)
    {
        if (line.Length >= 14 && line.Substring(0, 4) == "CSEG")
        {
            var top = int.Parse(line.Substring(5, 4), NumberStyles.HexNumber) & 0xffff;
            var tail = int.Parse(line.Substring(10, 4), NumberStyles.HexNumber) & 0xffff;
            min = Math.Min(min, top);
            max = Math.Max(max, tail);
        }
        line = reader.ReadLine();
    }
}

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine("BinSize equ " + (max - min + 1));
}
