public static void WriteByte(this Stream stream, int value)
{
    stream.WriteByte((byte)value);
}

public static void WriteBytes(this Stream stream, int value, int count)
{
    for (var i = 0; i < count; ++i)
    {
        stream.WriteByte((byte)value);
    }
}

public static void WriteWord(this Stream stream, int value)
{
    stream.WriteByte(value);
    stream.WriteByte(value >> 8);
}

public static void WriteDWord(this Stream stream, uint value)
{
    stream.WriteWord((ushort)value);
    stream.WriteWord((ushort)(value >> 16));
}

public static void WriteString(this Stream stream, string s)
{
    byte[] bytes = Encoding.ASCII.GetBytes(s);
    stream.WriteWord(bytes.Length);
    foreach (byte b in bytes)
    {
        stream.WriteByte(b);
    }
}

public static int ReadWord(this Stream stream)
{
    int l = stream.ReadByte();
    int h = stream.ReadByte();
    return l | (h << 8);
}

public static string ReadString(this Stream stream)
{
    int n = stream.ReadWord();
    StringBuilder s = new StringBuilder();
    for (int i = 0; i < n; ++i)
    {
        char c = (char)(stream.ReadByte());
        s.Append(c);
    }
    return s.ToString();
}


private static void WriteBytes(Stream stream, byte[] bytes)
{
    stream.WriteWord(bytes.Length + 1);
    byte sum = 0;
    foreach (var b in bytes)
    {
        sum ^= b;
        stream.WriteByte(b);
    }
    stream.WriteByte(sum);
}

private static byte[] ReadBytes(string fileName)
{
    using Stream stream = new FileStream(fileName, FileMode.Open, FileAccess.Read);
    List<byte> bytes = new List<byte>();
    int value;
    while ((value = stream.ReadByte()) >= 0)
    {
        bytes.Add((byte)value);
    }
    return bytes.ToArray();
}


private static void WriteString(Stream stream, string s, int size, byte filler)
{
    var bytes = Encoding.ASCII.GetBytes(s);
    var i = 0;
    foreach (var b in bytes)
    {
        if (i >= size)
            break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size)
    {
        stream.WriteByte(filler);
        ++i;
    }
}

var name = Args[0];

var sourceName = name + ".bin";
var directory = Path.GetDirectoryName(sourceName);
if (string.IsNullOrEmpty(directory))
{
    directory = Directory.GetCurrentDirectory();
}

var targetName = "bin.tap";
if (string.IsNullOrEmpty(Path.GetDirectoryName(targetName)))
{
    targetName = directory + Path.DirectorySeparatorChar + targetName;
}

var sourceBytes = ReadBytes(sourceName);

using (Stream outStream = new FileStream(targetName, FileMode.Create, FileAccess.Write))
{
    using (
        MemoryStream memoryStream = new MemoryStream())
    {
        memoryStream.WriteByte(0);
        memoryStream.WriteByte(3);
        WriteString(memoryStream, name, 10, 0x20);
        memoryStream.WriteWord(sourceBytes.Length);
        memoryStream.WriteWord(0x8000);
        memoryStream.WriteWord(0x8000);
        WriteBytes(outStream, memoryStream.ToArray());
    }
    using (MemoryStream memoryStream = new MemoryStream())
    {
        memoryStream.WriteByte(0xff);
        memoryStream.Write(sourceBytes);
        WriteBytes(outStream, memoryStream.ToArray());
    }
}