const int BlockSize = 256;
const int rate = 48000;
const short range = 0x7fff;

short[] MakeWave(int length, int count)
{
    // var wave = new short[length];
    // int index = 0;
    // for (var i = 0; i < count; ++i)
    // {
    //     for (var j = 0; j < wave.Length / count / 2; ++j)
    //     {
    //         wave[index++] = -range;
    //     }
    //     for (var j = 0; j < wave.Length / count / 2; ++j)
    //     {
    //         wave[index++] = range;
    //     }
    // }
    // return wave;
    var wave = new short[length];
    int index = 0;
    for (var i = 0; i < count; ++i)
    {
        for (var j = 0; j < wave.Length / count; ++j)
        {
            var angle = 2 * Math.PI / length * count * index;
            wave[index++] = (short)(range * Math.Sin(angle));
        }
    }
    return wave;
}

var wave0 = MakeWave(rate / 1200, 1);
var wave1 = MakeWave(rate / 1200, 2);

var waveValues = new List<short>();


void AddBit(int bit)
{
    waveValues.AddRange(bit != 0 ? wave1 : wave0);
}
void AddBits(int bit, int count)
{
    for (var i = 0; i < count; ++i)
    {
        AddBit(bit);
    }
}

void AddByte(int b)
{
    AddBit(0);
    var bit = 1;
    for (var i = 0; i < 8; ++i)
    {
        AddBit((b & bit) != 0 ? 1 : 0);
        bit <<= 1;
    }
    AddBit(1);
    AddBit(1);
    AddBit(1);
}

var name = Args[0];

var sourceBytes = new byte[0x8000];
int size;
using (var stream = new FileStream(name + ".cmt", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(sourceBytes);
    for (var i = 0; i < 1200 * 3; ++i)
    {
        AddBit(1);
    }
    for (var i = 0; i < size; ++i)
    {
        AddByte(sourceBytes[i]);
    }
}

using (var stream = new FileStream(name + ".wav", FileMode.Create, FileAccess.Write))
{
    void WriteWordL(ushort value)
    {
        stream.WriteByte((byte)(value & 0xff));
        stream.WriteByte((byte)(value >> 8));
    }

    void WriteDWordL(uint value)
    {
        WriteWordL((ushort)(value & 0xffff));
        WriteWordL((ushort)(value >> 16));
    }

    void WriteString(string s, int size)
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

    WriteString("RIFF", 4);
    WriteDWordL((uint)(36 + waveValues.Count * 2));
    WriteString("WAVE", 4);
    WriteString("fmt", 4);
    WriteDWordL(16);
    WriteWordL(1);
    WriteWordL(1);
    WriteDWordL(rate);
    WriteDWordL(rate * 2);
    WriteWordL(2);
    WriteWordL(16);
    WriteString("data", 4);
    WriteDWordL((uint)(waveValues.Count * 2));
    foreach (var value in waveValues)
    {
        WriteWordL((ushort)value);
    }
}
