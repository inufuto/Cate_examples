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
    writer.WriteLine($"{line} POKE&H1895,{l}:POKE&H1896,{h}"); line += 10;
    writer.WriteLine($"{line} POKE&H1897,{l}:POKE&H1898,{h}"); line += 10;
    writer.WriteLine($"{line} POKE&H1899,{l}:POKE&H189a,{h}"); line += 10;
    writer.WriteLine($"{line} PRINT \"CLEAR512,1024\""); line += 10;
}
