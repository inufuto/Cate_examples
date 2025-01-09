private static object Hex(int value)
{
    return $"${value:X}";
}

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);

var bin = new byte [0xf000];
int size ;
{
    using var stream = new FileStream(name + ".bin", FileMode.Open);
    size = stream.Read(bin);
}
{
    using var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8);
    writer.WriteLine("Top equ " + Hex(address));
    writer.WriteLine("Size equ " + Hex(size));
}
