var name = Args[0];

var bin = new byte[0xf000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine("BinSize equ " + binSize);
}
