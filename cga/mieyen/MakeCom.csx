var name = Args[0];

var end = 0x4000;
using (var reader = new StreamReader(name + "_com.symbols.txt", Encoding.ASCII))
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

var bin = new byte[0x10000];
var size = 0;
using (var stream = new FileStream(name + ".com.bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bin);
}

using (var stream = new FileStream(name + ".com", FileMode.Create, FileAccess.Write))
{
    stream.Write(bin, 0, end - 0x100);
}
