const int rate = 48000;
const short range = 0x7fff;

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
    foreach (var b in bytes) {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size) {
        stream.WriteByte(0x20);
        ++i;
    }
}


void MakeWave(short[] wave)
{
    for (var i = 0; i < wave.Length / 2; ++i) {
        wave[i] = range;
    }
    for (var i = 0; i < wave.Length / 2; ++i) {
        wave[i + wave.Length / 2] = -range;
    }
}

var lowWave = new short[40];
MakeWave(lowWave);
var highWave = new short[24];
MakeWave(highWave);

var values = new List<short>();
ushort sum;

void AddWave(short[] wave, int count)
{
    for (var i = 0; i < count; ++i) {
        values.AddRange(wave);
    }
}

void AddByte(byte b)
{
    AddWave(lowWave, 1);
    var bit = 0x80;
    while (bit != 0) {
        AddWave((b & bit) != 0 ? lowWave : highWave, 1);
        bit >>= 1;
    }
    sum += b;
}

void AddWord(ushort value)
{
    var h = (byte)(value >> 8);
    var l = (byte)(value & 0xff);
    AddByte(h);
    AddByte(l);
}

void AddString(string s, int size)
{
    var bs = Encoding.ASCII.GetBytes(s);
    var i = 0;
    foreach (var b in bs) {
        if (i >= size) break;
        AddByte(b);
        ++i;
    }
    while (i < size) {
        AddByte(0x00);
        ++i;
    }
}

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bytes = new byte[0x8000];
int size;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}


for (var i = 0; i < 720; ++i) {
    values.Add(-range);
}

AddWave(highWave, 4000);
AddWave(lowWave, 40);
AddWave(highWave, 40);
AddWave(lowWave, 1);
sum = 0;
AddByte(1); // type
AddString(name, 16);
AddByte(0);
AddWord((ushort)size);
AddWord((ushort)address);
AddWord((ushort)address);
for (var i = 0; i < 8; ++i) {
    AddByte(0);
}
AddWord((ushort)sum);

for (var i = 0; i < 720; ++i) {
    values.Add(-range);
}

AddWave(highWave, 4000);
AddWave(lowWave, 20);
AddWave(highWave, 20);
AddWave(lowWave, 1);
sum = 0;
for (var i=0;i<size;++i) {
    AddByte(bytes[i]);
}
AddWord(sum);

for (var i = 0; i < 720; ++i) {
    values.Add(-range);
}


using (var stream = new FileStream(name + ".wav", FileMode.Create, FileAccess.Write)) {
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
    foreach (var value in values) {
        WriteWordL(stream, (ushort)value);
    }
}
