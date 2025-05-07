const int rate = 48000;
const int BitLength = 48000 / 600;
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


void MakeWave(short[] wave, int rate)
{
    var length = 0;
    while (length < wave.Length) {
        for (var i = 0; i < rate; ++i) {
            wave[length++] = -range;
        }
        for (var i = 0; i < rate; ++i) {
            wave[length++] = range;
        }
    }
}

var lowWave = new short[BitLength];
MakeWave(lowWave, BitLength / 4);
var highWave = new short[BitLength];
MakeWave(highWave, BitLength / 8);

var values = new List<short>();

void AddWave(short[] wave, int count)
{
    for (var i = 0; i < count; ++i) {
        values.AddRange(wave);
    }
}

void AddByte(byte b)
{
    AddWave(lowWave, 1); // start
    for (var i = 0; i < 8; ++i) {
        if ((b & 1) != 0) {
            AddWave(highWave, 1);
        }
        else {
            AddWave(lowWave, 1);
        }        
        b >>= 1;
    }
    AddWave(highWave, 2); // stop
}


var name = Args[0];

using (var stream = new FileStream(name + ".cmt", FileMode.Open, FileAccess.Read)) {
    AddWave(highWave, 3000);
    while (true) {
        var b = stream.ReadByte();
        if (b < 0) break;
        AddByte((byte)b);
    }
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
