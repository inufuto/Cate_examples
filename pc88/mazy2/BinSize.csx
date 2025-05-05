var name = Args[0];

var bin = new byte[0xf000];
int binSize1;
using (var stream = new FileStream(name + "_v1.bin", FileMode.Open)) {
    binSize1 = stream.Read(bin);
}

int binSize2;
using (var stream = new FileStream(name + "_v2.bin", FileMode.Open)) {
    binSize2 = stream.Read(bin);
}

var binSize = Math.Max(binSize1, binSize2);

using (var writer = new StreamWriter("BinSize.inc", false, Encoding.UTF8))
{
    writer.WriteLine("BinSize equ " + binSize);
}
