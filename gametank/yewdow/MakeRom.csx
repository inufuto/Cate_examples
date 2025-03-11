var name = Args[0];

var bytes = new byte[0x4000];


using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    stream.Read(bytes);
}

using (var stream = new FileStream(name + ".gtr", FileMode.Create, FileAccess.Write))
{
    stream.Write(bytes);
}
