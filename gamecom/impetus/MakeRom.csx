var name = Args[0];

var bank20 = new byte[0x2000];
var bank21 = new byte[0x2000];
var bank22 = new byte[0x2000];
var bank23 = new byte[0x2000];

var bank24 = new byte[0x2000];
var bank25 = new byte[0x2000];

using (var stream = new FileStream("_.bin", FileMode.Open, FileAccess.Read))
{
    stream.Read(bank23); // 2000h
    stream.Read(bank20); // 4000h
    stream.Read(bank21); // 6000h
    stream.Read(bank22); // 8000h
}

using (var stream = new FileStream("_.char.bin", FileMode.Open, FileAccess.Read))
{
    stream.Read(bank24);
    stream.Read(bank25);
}

var sum = 0x5a - bank22[0x6f27 - 0x6000] - bank22[0x76e1 - 0x6000];
System.Console.Write($"{sum:x}");
bank23[0x7fdb - 0x6000] = (byte)sum;

void Write64k(FileStream stream)
{
    stream.Write(bank20);
    stream.Write(bank21);
    stream.Write(bank22);
    stream.Write(bank23);
    stream.Write(bank24);
    stream.Write(bank25);
    stream.Write(bank24);
    stream.Write(bank25);
}

using (var stream = new FileStream(name + ".bin", FileMode.Create, FileAccess.Write))
{
    Write64k(stream);
}

using (var stream = new FileStream(name + "_256k.bin", FileMode.Create, FileAccess.Write))
{
    for (var i = 0; i < 4; ++i)
    {
        Write64k(stream);
    }
}
