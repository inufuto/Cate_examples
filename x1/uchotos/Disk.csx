private const int NameSize = 17;

private const byte Protected = 0x00;
private const byte Type2D = 0x00;
private const int TrackCount = 40 * 2;
private const int SectorCount = 16;
private const int OffsetCount = 164;


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
        stream.WriteByte((byte)trackNumber);
        stream.WriteByte((byte)sideNumber);
        stream.WriteByte((byte)sectorNumber);
        stream.WriteByte(SizeType);
        WriteWord(stream, SectorCount);
        stream.WriteByte(Density);
        WriteRepeat(stream, 0, 1 + 1 + 5);
        WriteWord(stream, MaxSize);
        stream.Write(bytes.ToArray());
        WriteRepeat(stream, 0, MaxSize - bytes.Count);
    }

    public void AddBytes(IEnumerable<byte> bs)
    {
        bytes.AddRange(bs);
    }

    public void AddByte(byte b)
    {
        bytes.Add(b);
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

private static void BuildBootSector(string name, int address, int binSize)
{
    using var stream = new MemoryStream(Sector.MaxSize);
    stream.WriteByte(0x01);
    WriteString(stream, name, 13);
    WriteString(stream, "Sys", 3);
    stream.WriteByte(0x20);
    WriteWord(stream, (ushort)binSize);
    WriteWord(stream, (ushort)address);
    WriteWord(stream, (ushort)address);
    for (var i = 0; i < 6; ++i)
    {
        stream.WriteByte(0x00);
    }
    stream.WriteByte(0x01);
    stream.WriteByte(0x00);
    for (var i = 0; i < Sector.MaxSize - 32; ++i)
    {
        stream.WriteByte(0x00);
    }
    Tracks[0].Sectors[0].AddBytes(stream.ToArray());
}

private static void BuildSectors(byte[] bytes)
{
    var binIndex = 0;
    var trackNumber = 0;
    var sectorIndex = 1;
    while (binIndex < bytes.Length)
    {
        var sector=Tracks[trackNumber].Sectors[sectorIndex];
        for (var i=0;i<Sector.MaxSize;++i)
        {
            sector.AddByte(binIndex < bytes.Length ? bytes[binIndex] : (byte)0);
            ++binIndex;
        }
        ++sectorIndex;
        if (sectorIndex >= SectorCount)
        {
            ++trackNumber;
            sectorIndex = 0;
        }
    }
}


for (var i = 0; i < TrackCount; ++i)
{
    Tracks[i] = new Track(i);
}
var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);
var bin=new byte[0x10000];
int binSize;
{
    using var stream = new FileStream(name + ".bin", FileMode.Open);
    binSize = stream.Read(bin);
}
BuildBootSector(name, address, binSize);
BuildSectors(bin);
using (var stream = new FileStream(name + ".d88", FileMode.Create))
{
    WriteString(stream, name, NameSize);
    WriteRepeat(stream, 0, 9);
    stream.WriteByte(Protected);
    stream.WriteByte(Type2D);
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