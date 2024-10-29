var name = Args[0];

var bank20 = new byte[0x2000];
var bank21 = new byte[0x2000];
var bank22 = new byte[0x2000];
var bank23 = new byte[0x2000];

using (var stream = new FileStream("_.bin", FileMode.Open, FileAccess.Read))
{
    stream.Read(bank23); // 2000h
    stream.Read(bank20); // 4000h
    stream.Read(bank21); // 6000h
    stream.Read(bank22); // 8000h
}

var sum = 0x5a - bank22[0x6f27 - 0x6000] - bank22[0x76e1 - 0x6000];
System.Console.Write($"{sum:x}");
bank23[0x7fdb - 0x6000] = (byte)sum;

void Write32k(FileStream stream)
{
    stream.Write(bank20);
    stream.Write(bank21);
    stream.Write(bank22);
    stream.Write(bank23);
}

using (var stream = new FileStream(name + ".bin", FileMode.Create, FileAccess.Write))
{
    Write32k(stream);
}

using (var stream = new FileStream(name + "_256k.bin", FileMode.Create, FileAccess.Write))
{
    for (var i = 0; i < 8; ++i)
    {
        Write32k(stream);
    }
}
