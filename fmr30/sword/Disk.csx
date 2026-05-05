private const string LoaderName = "Loader.bin";

private const int NameSize = 17;

private const byte Protected = 0x00;
private const byte Type2HD = 0x20;
private const int TrackCount = 77 * 2;
private const int SectorCount = 8;
private const int OffsetCount = 164;
private const int LoaderTrackNumber = 0;


class Sector
{
    public const int MaxSize = 1024;
    private const byte SizeType = 0x03;
    private const byte Density = 0x00;
    public const int TotalSize = 16 + MaxSize;
    private readonly int trackNumber;
    private readonly int sideNumber;
    private readonly int sectorNumber;
    private readonly List<byte> bytes = new List<byte>();

    private static byte iii=0;

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
        WriteRepeat(stream, iii++, MaxSize - bytes.Count);
    }

    public void SetBytes(IEnumerable<byte> bs)
    {
        bytes.AddRange(bs);
    }

    public int Size() => bytes.Count;
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

private static void ReadLoader()
{
    using var stream = new FileStream(LoaderName, FileMode.Open);
    var index = 0;
    var bytes = new byte[Sector.MaxSize];
    while (stream.Read(bytes) > 0)
    {
        Tracks[LoaderTrackNumber].Sectors[index].SetBytes(bytes);
        ++index;
    }
}

private static void ReadProgram(string name)
{
    using var stream = new FileStream(name + ".bin", FileMode.Open);
    var trackNumber = LoaderTrackNumber;
    var sectorIndex = 1;
    var bytes = new byte[Sector.MaxSize];
    while (stream.Read(bytes) > 0)
    {
        Tracks[trackNumber].Sectors[sectorIndex].SetBytes(bytes);
        ++sectorIndex;
        if (sectorIndex >= SectorCount)
        {
            ++trackNumber;
            sectorIndex = 0;
        }
    }
}


var name = Args[0];
for (var i = 0; i < TrackCount; ++i)
{
    Tracks[i] = new Track(i);
}
ReadLoader();
ReadProgram(name);
using (var stream = new FileStream(name + ".d88", FileMode.Create))
{
    WriteString(stream, name, NameSize);
    WriteRepeat(stream, 0, 9);
    stream.WriteByte(Protected);
    stream.WriteByte(Type2HD);
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