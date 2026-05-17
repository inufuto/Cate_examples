const int DataSegmentSize = 0x0b00;

var name = Args[0];

var cseg = new byte[0x10000];
using (var stream = new FileStream(name + ".bin", FileMode.Open))
{
    stream.Read(cseg);
}

var dseg = new byte[DataSegmentSize];
using (var stream = new FileStream(name + ".dseg.bin", FileMode.Open))
{
    stream.Read(dseg);
}

var filler = new byte[0x80000 - 0x10000 - DataSegmentSize];

using (var stream = new FileStream(name + ".ngp", FileMode.Create))
{
    stream.Write(cseg);
    stream.Write(dseg);
    stream.Write(filler);
}

using (var stream = new FileStream("---.ngp", FileMode.Create))
{
    stream.Write(cseg);
    stream.Write(dseg);
}
