const int BankCount = 16;
const int BankSize = 0x0ef0;
const int LoaderSize = 0x100;

var name = Args[0];

var Loader = new byte[LoaderSize];
using (var stream = new FileStream("Loader.bin", FileMode.Open))
{
    stream.Read(Loader);
}

var Bin = new byte[0x10000];
using (var stream = new FileStream(name + ".bin", FileMode.Open))
{
    stream.Read(Bin);
}

var Port = new byte[0x10];

var address = 0;
using (var stream = new FileStream(name + ".rom", FileMode.Create))
{
    for (var i = 0; i < BankCount; ++i)
    {
        stream.Write(Loader);
        stream.Write(Bin, address, BankSize);
        stream.Write(Port);
        address += BankSize;
    }
}