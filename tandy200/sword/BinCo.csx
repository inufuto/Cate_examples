private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)value);
    stream.WriteByte((byte)(value >> 8));
}


var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name + ".co", FileMode.Create, FileAccess.Write))
{
    WriteWord(stream, (ushort)address);
    WriteWord(stream, (ushort)size);
    WriteWord(stream, (ushort)address);
    stream.Write(bytes, 0, size);
    var sum = 0;
    foreach (var b in bytes) {
        sum += b;
    }
    stream.WriteByte((byte)(-sum));
}
