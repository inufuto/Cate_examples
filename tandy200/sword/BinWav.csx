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
    var r = wave.Length > 20 ? range : range * 3 / 4;
    for (var i = 0; i < wave.Length / 2; ++i) {
        wave[i] = (short)(-r);
    }
    for (var i = 0; i < wave.Length / 2; ++i) {
        wave[i + wave.Length / 2] = (short)r;
    }
}

var lowWave = new short[rate / 1200];
MakeWave(lowWave);
var highWave = new short[rate / 2400];
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
        AddWave((b & bit) == 0 ? lowWave : highWave, 1);
        bit >>= 1;
    }
    sum += b;
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
    foreach (var b in bs) {
        if (i >= size) break;
        AddByte(b);
        ++i;
    }
    while (i < size) {
        AddByte(0x20);
        ++i;
    }
}

void AddHead()
{
    for (var i = 0; i < 512 * 4; ++i) {
        AddWave(lowWave, 1);
        AddWave(highWave, 1);
    }
    AddWave(lowWave, 1);
    for (var i = 0; i < 7; ++i) {
        AddWave(highWave, 1);
    }
}

void AddBlank(int count)
{
    for (var i = 0; i < count; ++i) {
        values.Add(0);
    }
}

void SaveWav(byte type, string name, int address, int size, byte[] bytes, string wavName)
{
    values.Clear();

    AddHead();
    AddByte(type);
    sum = 0;
    AddString(name, 6);
    AddWord((ushort)address);
    AddWord((ushort)size);
    AddWord((ushort)address);
    AddByte(0x00); 
    AddByte(0xff); 
    AddByte(0x00); 
    AddByte(0xef); 
    AddByte((byte)(-sum));

    AddBlank(12000);

    AddHead();
    AddByte(0x8d); // type
    sum = 0;
    for (var i=0;i<size;++i) {
        AddByte(bytes[i]);
    }
    AddByte((byte)(-sum));

    using (var stream = new FileStream(wavName, FileMode.Create, FileAccess.Write)) {
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
}


var name = Args[0];
{
    var bytes = new byte[0x8000];
    int size;
    using (var stream = new FileStream("cloader.ba", FileMode.Open, FileAccess.Read))
    {
        size = stream.Read(bytes);
    }
    SaveWav(0xd3, "LOADER", 0x8000, size, bytes, name + "_1.wav");
}
{
    var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);
    var bytes = new byte[0x8000];
    int size;
    using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
    {
        size = stream.Read(bytes);
    }
    SaveWav(0xd0, name, address, size, bytes, name + "_2.wav");
}
