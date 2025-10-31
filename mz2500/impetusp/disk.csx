private const byte Protected = 0x00;
private const byte Type2DD = 0x10;
private const int TrackCount = 80 * 2;
private const int SectorCount = 16;
private const int OffsetCount = 164;

private const int Address = 0x4000;
private const int BlockCount = 4; // 32KB

class Sector
{
    public const int MaxSize = 256;
    private const byte SizeType = 0x01;
    private const byte Density = 0x00;
    public const int TotalSize = 16 + MaxSize;
    private readonly int trackNumber;
    private readonly int sideNumber;
    private readonly int sectorNumber;
    private readonly List<byte> bytes = new List<byte>();

    public Sector(int trackNumber, int index)
    {
        this.trackNumber = trackNumber / 2;
        sideNumber = trackNumber % 2;
        sectorNumber = index + 1;
    }

    public void Write(Stream stream)
    {
        for (var i = 0; i < bytes.Count; ++i) {
            bytes[i] ^= 0xff;
        }
        stream.WriteByte((byte)trackNumber);
        stream.WriteByte((byte)sideNumber);
        stream.WriteByte((byte)sectorNumber);
        stream.WriteByte(SizeType);
        WriteWord(stream, SectorCount);
        stream.WriteByte(Density);
        WriteRepeat(stream, 0, 1 + 1 + 5);
        WriteWord(stream, MaxSize);
        stream.Write(bytes.ToArray());
        WriteRepeat(stream, 0xff, MaxSize - bytes.Count);
    }

    public void AddBytes(IEnumerable<byte> bs)
    {
        bytes.AddRange(bs);
    }

    public void AddByte(byte b)
    {
        bytes.Add(b);
    }

    public void AddWord(ushort value) 
    {
        AddByte((byte)value);
        AddByte((byte)(value >> 8));
    }

    public void AddString(string s, int size) 
    {
        var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
        var i = 0;
        foreach (var b in bytes)
        {
            if (i >= size) break;
            AddByte(b);
            ++i;
        }
        while (i < size)
        {
            AddByte(0);
            ++i;
        }
    }
}

class Track
{
    public const int TotalSize = Sector.TotalSize * SectorCount;
    public readonly Sector[] Sectors = new Sector[SectorCount];

    public Track(int trackNumber)
    {
        for (var i = 0; i < Sectors.Length; ++i)
        {
            Sectors[i] = new Sector(trackNumber, i);
        }
    }


    public void Write(Stream stream)
    {
        foreach (var sector in Sectors)
        {
            sector.Write(stream);
        }
    }
}

private static readonly Track[] Tracks = new Track[TrackCount];
private static int TotalSize => 0x20 + 4 * OffsetCount + Track.TotalSize * TrackCount;


private static void WriteString(Stream stream, string s, int size)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bytes)
    {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size)
    {
        stream.WriteByte(0);
        ++i;
    }
}

private static void WriteRepeat(Stream stream, byte value, int size)
{
    for (var i = 0; i < size; ++i)
    {
        stream.WriteByte(value);
    }
}

private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)value);
    stream.WriteByte((byte)(value >> 8));
}

private static void WriteDWord(Stream stream, uint value)
{
    WriteWord(stream, (ushort)value);
    WriteWord(stream, (ushort)(value >> 16));
}

private void BuildFirstSector(string name)
{
    var Pages = new byte[]  { 
        0, 1, 2, 3, 4, 5, 0x39, 0x38
    };
    var sector = Tracks[1].Sectors[0];
    sector.AddByte(1);
    sector.AddString("IPLPRO", 6);
    sector.AddString(name, 16);
    sector.AddByte(0x0d);
    sector.AddWord(Address);
    
    for (var i = 0; i < 4; ++i) {
        sector.AddByte(0);
    }
    sector.AddWord(1 * SectorCount + 0);
    for (var i = 0; i < BlockCount; ++i) {
        sector.AddByte((byte)(Address / 0x2000 + i));
    }
    for (var i = 0; i < 16 - BlockCount; ++i) {
        sector.AddByte(0xff);
    }
    sector.AddBytes(Pages);
}

private static void ReadProgram(string name)
{
    using var stream = new FileStream(name + ".bin", FileMode.Open);
    var c = 0;
    var trackNumber = 0;
    var sectorIndex = 0;
    var bytes = new byte[Sector.MaxSize];
    while (stream.Read(bytes) > 0)
    {
        Tracks[trackNumber].Sectors[sectorIndex].AddBytes(bytes);
        ++sectorIndex;
        if (sectorIndex >= SectorCount)
        {
            if ((trackNumber % 2) == 0) {
                trackNumber += 3;
            }
            else {
                --trackNumber;
            }
            sectorIndex = 0;
        }
        ++c;
    }
    Console.WriteLine(c);
}


var name = Args[0];
for (var i = 0; i < TrackCount; ++i)
{
    Tracks[i] = new Track(i);
}
BuildFirstSector(name);
ReadProgram(name);
using (var stream = new FileStream(name + ".d88", FileMode.Create))
{
    WriteString(stream, name, 17);
    WriteRepeat(stream, 0, 9);
    stream.WriteByte(Protected);
    stream.WriteByte(Type2DD);
    WriteDWord(stream, (uint)TotalSize);

    var position = 0x20 + 4 * OffsetCount;
    for (var i = 0; i < TrackCount; ++i)
    {
        WriteDWord(stream, (uint)position);
        position += Track.TotalSize;
    }
    for (var i = 0; i < OffsetCount - TrackCount; ++i)
    {
        WriteDWord(stream, 0);
    }
    for (var i = 0; i < TrackCount; ++i)
    {
        Tracks[i].Write(stream);
    }
}