private const string Loader1Name = "Loader1.bin";
private const int Loader1SectorCount = 1;
private const string Loader2Name = "Loader2.bin";
private const int Loader2SectorCount = 2;

private const int NameSize = 17;

private const byte Protected = 0x00;
private const byte Type2D = 0x00;
private const int TrackCount = 40 * 2;
private const int SectorCount = 16;
private const int OffsetCount = 164;
private const int LoaderTrackNumber = 0;


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

    public void SetBytes(IEnumerable<byte> bs)
    {
        bytes.AddRange(bs);
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

private static void ReadLoader()
{
    var index = 0;
    var bytes = new byte[Sector.MaxSize];
    using (var stream = new FileStream(Loader1Name, FileMode.Open))
    {
        for (var i = 0; i < Loader1SectorCount; ++i)
        {
            stream.Read(bytes);
            Tracks[LoaderTrackNumber].Sectors[index].SetBytes(bytes);
            ++index;
        }
    }
    using (var stream = new FileStream(Loader2Name, FileMode.Open))
    {
        for (var i = 0; i < Loader2SectorCount; ++i)
        {
            stream.Read(bytes);
            Tracks[LoaderTrackNumber].Sectors[index].SetBytes(bytes);
            ++index;
        }
    }
}

private static void ReadProgram(string name)
{
    using var stream = new FileStream(name + ".bin", FileMode.Open);
    var trackNumber = LoaderTrackNumber;
    var sectorIndex = Loader1SectorCount + Loader2SectorCount;
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