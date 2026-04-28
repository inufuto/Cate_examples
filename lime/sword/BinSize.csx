using System.Globalization;

var name = Args[0];
var cseg = Args[1];

var csegSize = SegSize("CSEG");
var dsegSize = SegSize("DSEG");

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine("BinSize equ " + csegSize);
    writer.WriteLine("BinTop equ $" + cseg);
    writer.WriteLine("AllSize equ " + (csegSize + dsegSize));
}

int SegSize(string segName)
{
    var min = int.MaxValue;
    var max = int.MinValue;

    using (var reader = new StreamReader(name + ".symbols.txt", Encoding.UTF8))
    {
        var line = reader.ReadLine();
        while (line != null)
        {
            if (line.Length >= 14 && line.Substring(0, 4) == segName)
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