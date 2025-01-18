const int SectorSize = 256;
const int SectorCount = 16;
const int TrackCount = 35;

static var aaa = 0;

class Sector
{
    public readonly byte[] Bytes = new byte[SectorSize];

    public Sector()
    {
        for (int i = 0; i < SectorSize; ++i)
        {
            Bytes[i] = (byte)aaa;
        }
        ++aaa;
    }
};

class Track
{
    public readonly Sector[] Sectors = new Sector[SectorCount];

    public Track()
    {
        for (var i = 0; i < Sectors.Length; ++i)
        {
            Sectors[i] = new Sector();
        }
    }
};

var Tracks = new Track[TrackCount];
for (var i = 0; i < TrackCount; ++i)
{
    Tracks[i] = new Track();
}

using (var stream = new FileStream("Loader.bin", FileMode.Open))
{
    stream.Read(Tracks[0].Sectors[0].Bytes);
}

var name = Args[0];

using (var stream = new FileStream(name + ".bin", FileMode.Open))
{
    var trackIndex = 0;
    var sectorIndex = 1;
    while (stream.Read(Tracks[trackIndex].Sectors[sectorIndex].Bytes) > 0)
    {
        if (++sectorIndex >= SectorCount)
        {
            sectorIndex = 0;
            ++trackIndex;
        }
    }
}



using (var stream = new FileStream(name + ".dsk", FileMode.Create))
{
    foreach (var track in Tracks)
    {
        foreach (var sector in track.Sectors)
        {
            stream.Write(sector.Bytes);
        }
    }
}