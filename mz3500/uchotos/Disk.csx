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

    public void SetBytes(IEnumerable<byte> bs)
    {
        bytes.AddRange(bs);
        if (bytes.Count > MaxSize)
        {
            throw new InvalidOperationException("Sector data exceeds 256 bytes.");
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

record struct Position(int trackNumber, int sectorIndex);

Position WriteBin(byte[] data, Position position, int sectorCount)
{
    for (var i = 0; i < sectorCount; ++i)
    {
        var offset = i * Sector.MaxSize;
        var length = Math.Max(0, Math.Min(Sector.MaxSize, data.Length - offset));
        Tracks[position.trackNumber].Sectors[position.sectorIndex]
            .SetBytes(data.Skip(offset).Take(length));
        ++position.sectorIndex;
        if (position.sectorIndex == SectorCount)
        {
            ++position.trackNumber;
            position.sectorIndex = 0;
        }
    }
    return position;
}


if (Args.Count() != 1)
{
    throw new ArgumentException("Usage: dotnet script Disk.csx <name>");
}

var name = Args[0];
for (var i = 0; i < TrackCount; ++i)
{
    Tracks[i] = new Track(i);
}

const int address = 0x8000;
const int transferBlockSize = 1024;
var subData = File.ReadAllBytes("sub.bin");
var mainData = File.ReadAllBytes(name + ".bin");
if (subData.Length == 0 || subData.Length > 16 * transferBlockSize)
{
    throw new InvalidOperationException("sub.bin must contain 1 to 16384 bytes.");
}
// The boot block reads at most one track (16 sectors) to the load address.
// The rest is read by an additional table into the A000h buffer (A000h-F7FFh)
// and copied to just after the boot block part.
const int bootBlockMaxSize = SectorCount * Sector.MaxSize;
const int tableBufferMaxSize = 0xf800 - 0xa000;
if (mainData.Length == 0 || mainData.Length > bootBlockMaxSize + tableBufferMaxSize)
{
    throw new InvalidOperationException(
        $"The main program must contain 1 to {bootBlockMaxSize + tableBufferMaxSize} bytes.");
}

var subBlocks = (subData.Length + transferBlockSize - 1) / transferBlockSize;
var subSectors = subBlocks * transferBlockSize / Sector.MaxSize;
var mainSectors = (mainData.Length + Sector.MaxSize - 1) / Sector.MaxSize;
var bootSectors = Math.Min(mainSectors, SectorCount);
var tableSectors = mainSectors - bootSectors;
var tableDest = address + bootSectors * Sector.MaxSize;
var tableLength = mainData.Length - bootSectors * Sector.MaxSize;
var subSysPosition = new Position(0, 1);
var mainSysPosition = WriteBin(subData, subSysPosition, subSectors);
if (mainSysPosition.sectorIndex != 0)
{
    mainSysPosition = new Position(mainSysPosition.trackNumber + 1, 0);
}
var mainBootPosition = mainSysPosition;
WriteBin(mainData, mainSysPosition, mainSectors);
var tableReadPosition = new Position(mainBootPosition.trackNumber + 1, 0);

var bootBytes = new byte[Sector.MaxSize];
var bootIndex = 0;
bootBytes[bootIndex++] = 0xaa; // 4449h
bootBytes[bootIndex++] = 0x14;

bootBytes[bootIndex++] = (byte)(mainBootPosition.trackNumber / 2);
bootBytes[bootIndex++] = (byte)(mainBootPosition.trackNumber % 2);
bootBytes[bootIndex++] = (byte)(mainBootPosition.sectorIndex + 1);
bootBytes[bootIndex++] = 1; // MFM, 256 bytes per sector
bootBytes[bootIndex++] = (byte)bootSectors;

bootBytes[bootIndex++] = (byte)(address % 0x100);
bootBytes[bootIndex++] = (byte)(address / 0x100);
bootBytes[bootIndex++] = (byte)(address % 0x100);
bootBytes[bootIndex++] = (byte)(address / 0x100);
for (var i = 0; i < 4; ++i)
{
    bootBytes[bootIndex++] = (byte)subBlocks;
}
var tableOffsetsIndex = bootIndex;
bootIndex += 8;
var subPosition = subSysPosition;
var remaining = subSectors;
while (remaining > 0)
{
    var count = Math.Min(remaining, SectorCount - subPosition.sectorIndex);
    bootBytes[bootIndex++] = (byte)(subPosition.trackNumber / 2);
    bootBytes[bootIndex++] = (byte)(subPosition.trackNumber % 2);
    bootBytes[bootIndex++] = (byte)(subPosition.sectorIndex + 1);
    bootBytes[bootIndex++] = 1;
    bootBytes[bootIndex++] = (byte)count;
    remaining -= count;
    subPosition = new Position(subPosition.trackNumber + 1, 0);
}
bootBytes[bootIndex++] = 0xff;

// Both table pointer groups are always processed by the IPL.
// The first group points to the main program table, the second to the dummy.
var mainTableOffset = bootIndex;
if (tableSectors > 0)
{
    bootBytes[bootIndex++] = (byte)(tableDest % 0x100);
    bootBytes[bootIndex++] = (byte)(tableDest / 0x100);
    bootBytes[bootIndex++] = (byte)(tableLength % 0x100);
    bootBytes[bootIndex++] = (byte)(tableLength / 0x100);
    var tablePosition = tableReadPosition;
    var tableRemaining = tableSectors;
    while (tableRemaining > 0)
    {
        var count = Math.Min(tableRemaining, SectorCount);
        bootBytes[bootIndex++] = (byte)(tablePosition.trackNumber / 2);
        bootBytes[bootIndex++] = (byte)(tablePosition.trackNumber % 2);
        bootBytes[bootIndex++] = 1;
        bootBytes[bootIndex++] = 1;
        bootBytes[bootIndex++] = (byte)count;
        tableRemaining -= count;
        tablePosition = new Position(tablePosition.trackNumber + 1, 0);
    }
    bootBytes[bootIndex++] = 0xff;
}
var dummyTableOffset = bootIndex;
for (var i = 0; i < 4; ++i)
{
    bootBytes[tableOffsetsIndex + i] = (byte)(tableSectors > 0 ? mainTableOffset : dummyTableOffset);
    bootBytes[tableOffsetsIndex + 4 + i] = (byte)dummyTableOffset;
}
bootBytes[bootIndex++] = 0x00; // Dummy table: copy one byte from A000h to itself.
bootBytes[bootIndex++] = 0xa0;
bootBytes[bootIndex++] = 0x01;
bootBytes[bootIndex++] = 0x00;
bootBytes[bootIndex++] = 0xff;
Tracks[0].Sectors[0].SetBytes(bootBytes);

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