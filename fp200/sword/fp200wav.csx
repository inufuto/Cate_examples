const int rate = 48000;
const short range = 0x7fff;

var basic = new byte[] { 0x0c, 0x0a, 0x00, 0x20, 0x04, 0x4d, 0x20, 0x33, 0x35, 0x31, 0x32, 0x35, 0x00, 0x00 };

void WriteWordL(Stream stream, ushort value)
{
    stream.WriteByte((byte)(value & 0xff));
    stream.WriteByte((byte)(value >> 8));
}

void WriteDWordL(Stream stream, uint value)
{
    WriteWordL(stream, (ushort)(value & 0xffff));
    WriteWordL(stream, (ushort)(value >> 16));
}

static void WriteString(Stream stream, string s, int size)
{
    var bytes = Encoding.ASCII.GetBytes(s);
    var i = 0;
    foreach (var b in bytes)
    {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size)
    {
        stream.WriteByte(0x20);
        ++i;
    }
}


void MakeWave(short[] wave, int rate)
{
    var length = 0;
    while (length < wave.Length)
    {
        for (var i = 0; i < rate; ++i)
        {
            wave[length++] = -range;
        }
        for (var i = 0; i < rate; ++i)
        {
            wave[length++] = range;
        }
    }
}

var lowWave = new short[160];
MakeWave(lowWave, 20);
var highWave = new short[160];
MakeWave(highWave, 10);

var values = new List<short>();
byte sum;

void AddWave(short[] wave, int count)
{
    for (var i = 0; i < count; ++i)
    {
        values.AddRange(wave);
    }
}

void AddByte(byte b)
{
    var parity = 0;
    sum -= b;
    AddWave(lowWave, 1); // start
    for (var i = 0; i < 8; ++i)
    {
        if ((b & 1) != 0)
        {
            AddWave(highWave, 1);
            parity ^= 1;
        }
        else
        {
            AddWave(lowWave, 1);
        }
        b >>= 1;
    }
    if (parity != 0)
    {
        AddWave(highWave, 1);
    }
    else
    {
        AddWave(lowWave, 1);
    }
    AddWave(highWave, 2); // stop
}

void AddBytes(byte b, int count)
{
    for (var i = 0; i < count; ++i)
    {
        AddByte(b);
    }
}

void AddWord(ushort value)
{
    var h = (byte)(value >> 8);
    var l = (byte)(value & 0xff);
    AddByte(l);
    AddByte(h);
}

void AddString(string s, int size)
{
    var bs = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bs)
    {
        if (i >= size) break;
        AddByte(b);
        ++i;
    }
    while (i < size)
    {
        AddByte(0x20);
        ++i;
    }
}

var name = Args[0];

var bytes = new byte[0x8000];
int size;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

AddWave(highWave, 1000);
sum = 0;
AddByte(0x48);
AddByte(0x10);
AddString(name, 11);
AddByte(0xff);
AddBytes(0x00, 13);
AddWord((ushort)(basic.Length + size));
AddBytes(0x00, 4);
AddBytes(sum, 2);

AddWave(highWave, 1000);
sum = 0;
AddByte(0x44);
AddByte(0x10);
AddByte(0xff);
foreach (var b in basic)
{
    AddByte(b);
}
for (var i = 0; i < size; ++i)
{
    AddByte(bytes[i]);
}
AddBytes(sum, 2);

using (var stream = new FileStream(name + ".wav", FileMode.Create, FileAccess.Write))
{
    WriteString(stream, "RIFF", 4);
    WriteDWordL(stream, (uint)(36 + values.Count * 2));
    WriteString(stream, "WAVE", 4);
    WriteString(stream, "fmt", 4);
    WriteDWordL(stream, 16);
    WriteWordL(stream, 1);
    WriteWordL(stream, 1);
    WriteDWordL(stream, rate);
    WriteDWordL(stream, rate * 2);
    WriteWordL(stream, 2);
    WriteWordL(stream, 16);
    WriteString(stream, "data", 4);
    WriteDWordL(stream, (uint)(values.Count * 2));
    foreach (var value in values)
    {
        WriteWordL(stream, (ushort)value);
    }
}
