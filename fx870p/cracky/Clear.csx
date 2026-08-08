var name = Args[0];

var end = 0x4000;
using (var reader = new StreamReader(name + ".symbols.txt", Encoding.ASCII))
{
    while (!reader.EndOfStream)
    {
        var s = reader.ReadLine();
        if (s.StartsWith("DSEG"))
        {
            end = int.Parse(s.Substring(10), System.Globalization.NumberStyles.HexNumber);
            end = (end + 15) & 0xfff0;
        }
    }
}
var h = (byte)(end / 256);
var l = (byte)(end % 256);

using (var writer = new StreamWriter("clear.bas", false, Encoding.ASCII))
{
    var line = 10;
    writer.WriteLine($"{line} poke&h1895,{l}:poke&h1896,{h}"); line += 10;
    writer.WriteLine($"{line} poke&h1897,{l}:poke&h1898,{h}"); line += 10;
    writer.WriteLine($"{line} poke&h1899,{l}:poke&h189a,{h}"); line += 10;
    writer.WriteLine($"{line} print \"CLEAR512,1024\""); line += 10;
}
