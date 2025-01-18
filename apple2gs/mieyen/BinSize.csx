var name = Args[0];
var cseg = Args[1];

var bin = new byte[0xf000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.ASCII))
{
    writer.WriteLine("BinSize equ " + binSize);
    writer.WriteLine("Entry equ $" + cseg);
}
