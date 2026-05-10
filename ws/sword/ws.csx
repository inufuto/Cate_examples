const int MetaDataSize = 0x10;
const int DataSegmentSize = 0x0e00;
var name = Args[0];

var metaData = new byte[MetaDataSize];
using (var stream = new FileStream("MetaData.bin", FileMode.Open))
{
    stream.Read(metaData);
}

var cseg = new byte[0x10000 - DataSegmentSize - MetaDataSize];
using (var stream = new FileStream(name + ".bin", FileMode.Open))
{
    stream.Read(cseg);
}

var dseg = new byte[DataSegmentSize];
using (var stream = new FileStream(name + ".dseg.bin", FileMode.Open))
{
    var s = stream.Read(dseg);
    System.Console.WriteLine(s);
}

using (var stream = new FileStream(name + ".ws", FileMode.Create))
{
    stream.Write(cseg);
    stream.Write(dseg);
    stream.Write(metaData);
}
