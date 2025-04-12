var name = Args[0];
var binStart = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bin = new byte[0xf000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine($"BinStart equ 0{binStart:X}h");
    writer.WriteLine($"BinEnd equ 0{binStart+binSize:X}h");
    writer.WriteLine($"BinSize equ 0{binSize:X}h");
}
