var name = Args[0];

var bin4000 = new byte[0x4000];
var bin8000 = new byte[0x4000];

using (var stream = new FileStream("_raw.bin", FileMode.Open))
{
    stream.Read(bin4000);
    stream.Read(bin8000);
}

using (var stream = new FileStream(name+".bin", FileMode.Create, FileAccess.Write))
{
    stream.Write(bin8000);
    stream.Write(bin4000);
}