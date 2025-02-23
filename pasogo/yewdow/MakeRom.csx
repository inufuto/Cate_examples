const int ResetSize = 0x10;

var name = Args[0];

var reset = new byte[ResetSize];
using (var stream = new FileStream("Reset.bin", FileMode.Open))
{
    stream.Read(reset);
}

var loader = new byte[0x1000];
int loaderSize;
using (var stream = new FileStream("Loader.bin", FileMode.Open))
{
    loaderSize = stream.Read(loader);
}

var cseg = new byte[0x10000 - ResetSize - loaderSize];
using (var stream = new FileStream(name + ".bin", FileMode.Open))
{
    stream.Read(cseg);
}

using (var stream = new FileStream(name + ".rom", FileMode.Create))
{
    stream.Write(loader, 0, loaderSize);
    stream.Write(cseg);
    stream.Write(reset);
}
