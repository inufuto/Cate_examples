const int BlockSize = 256;
const int rate = 48000;
const short range = 0x7fff;

var name = Args[0];

void MakeWave(short[] wave)
{
    for (var i = 0; i < wave.Length / 2; ++i)
    {
        wave[i] = -range;
    }
    for (var i = 0; i < wave.Length / 2; ++i)
    {
        wave[i + wave.Length / 2] = range;
    }
}

var wave0 = new short[rate / 2000];
MakeWave(wave0);
var wave1 = new short[rate / 1000];
MakeWave(wave1);

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
    var bit = 1;
    for (var i = 0; i < 8; ++i)
    {
        AddBit((b & bit) != 0 ? 1 : 0);
        bit <<= 1;
    }
    AddBit(1);
}

void AddBytes(params byte[] bytes)
{
    foreach (var b in bytes)
    {
        AddByte(b);
    }
}

void AddString(string s)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bytes)
    {
        AddByte(b);
        ++i;
    }
}

void AddGap(int count)
{
    for (var i = 0; i < count; ++i)
    {
        AddByte(0xff);
    }
}

void AddPreamble()
{
    AddBits(0, 80);
    AddBit(1);
    AddBytes(0xff, 0xaa);
}

void AddPostamble()
{
    AddBytes(0xaa, 0x00);
}

byte[] CRC(List<byte> bytes)
{
    var crc = 0;
    foreach (var b in bytes)
    {
        crc ^= b;
        for (var i = 0; i < 8; ++i)
        {
            if ((crc & 0x0001) == 0x0001)
                crc = ((crc >> 1) ^ 0x8408);
            else
                crc = crc >> 1;
        }
    }
    var low = (byte)crc;
    var high = (byte)(crc >> 8);
    return new byte[] { low, high };
}

List<byte> StringBytes(string s, int size)
{
    var destination = new List<byte>();
    var source = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in source)
    {
        if (i >= size) break;
        destination.Add(b);
        ++i;
    }
    while (i < size)
    {
        destination.Add(0x20);
        ++i;
    }
    return destination;
}


void MakeWaveValues(string fileName, byte[] fileType)
{
    List<byte> MakeHeader(string label)
    {
        var header = new List<byte>();
        header.AddRange(StringBytes(label, 4));
        header.AddRange(StringBytes(name, 11));
        header.AddRange(fileType);
        header.AddRange(StringBytes("2S  256", 12));
        header.AddRange(StringBytes(DateTime.Now.ToString("MMddyyHHmmss"), 12 + 8));
        header.AddRange(StringBytes("HX-20", 28));
        return header;
    }

    var blockNumber = 0;

    void AddBlock(List<byte> body, char type)
    {
        for (var copy = 0; copy < 2; ++copy)
        {
            AddPreamble();
            List<byte> bytes = new List<byte>();
            bytes.Add(Encoding.ASCII.GetBytes(new char[] { type })[0]);
            bytes.Add((byte)(blockNumber >> 8));
            bytes.Add((byte)(blockNumber & 0xff));
            bytes.Add((byte)copy);
            bytes.AddRange(body);
            AddBytes(bytes.ToArray());
            AddBytes(CRC(bytes));
            AddPostamble();
            AddGap(50);
        }
    }

    var sourceBytes = new byte[0x8000];
    int size;
    using (var stream = new FileStream(fileName, FileMode.Open, FileAccess.Read))
    {
        size = stream.Read(sourceBytes);
    }

    AddGap(100);

    var header = MakeHeader("HDR1");
    Debug.Assert(header.Count == 80);
    AddBlock(header, 'H');
    AddGap(100);
    ++blockNumber;

    var offset = 0;
    while (offset < size)
    {
        var length = Math.Min(size - offset, BlockSize);
        var block = new List<byte>();
        for (var i = 0; i < length; ++i)
        {
            block.Add(sourceBytes[offset + i]);
        }
        while (block.Count < BlockSize)
        {
            block.Add(0);
        }
        AddBlock(block, 'D');
        ++blockNumber;
        offset += length;
    }

    var eof = MakeHeader("EOF");
    Debug.Assert(eof.Count == 80);
    AddBlock(eof, 'E');
    AddGap(100);
    ++blockNumber;

    AddGap(300);
    AddBit(0);
}

MakeWaveValues("loader.bin", new byte[] { 0, 0, 0, 0, 0 });
MakeWaveValues(name + ".hc20bin", new byte[] { 2, 0, 0, 0, 0 });

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
