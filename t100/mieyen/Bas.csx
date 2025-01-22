const int LoadCode = 0x9b;
const int ClearCode = 0xa7;
const int CallCode = 0xb9;

private static void WriteWord(Stream stream, ushort value)
{
    stream.WriteByte((byte)value);
    stream.WriteByte((byte)(value >> 8));
}

static void WriteString(Stream stream, string s)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    foreach (var b in bytes) {
        stream.WriteByte(b);
    }
}

static void WriteString(Stream stream, string s, int size)
{
    var bytes = Encoding.ASCII.GetBytes(s.ToUpper());
    var i = 0;
    foreach (var b in bytes) {
        if (i >= size) break;
        stream.WriteByte(b);
        ++i;
    }
    while (i < size) {
        stream.WriteByte(0x20);
        ++i;
    }
}


var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);
var code = int.Parse(Args[2], System.Globalization.NumberStyles.AllowHexSpecifier);
var loaderName = "loader.ba";
if (code != LoadCode) {
    loaderName = "c" + loaderName;
}
var addressString = string.Format("{0}", address);

using (var stream = new FileStream(loaderName, FileMode.Create, FileAccess.Write))
{
    WriteWord(stream, 0x800e);
    WriteWord(stream, 10);
    stream.WriteByte(ClearCode);
    WriteString(stream, "0,");
    WriteString(stream, addressString);
    stream.WriteByte(0x00);

    WriteWord(stream, 0x801d);
    WriteWord(stream, 20);
    stream.WriteByte((byte)code);
    WriteString(stream, "M\"");
    WriteString(stream, name, 6);
    WriteString(stream, "\"");
    stream.WriteByte(0x00);

    WriteWord(stream, 0x8028);
    WriteWord(stream, 30);
    stream.WriteByte(CallCode);
    WriteString(stream, addressString);
    stream.WriteByte(0x00);
}
