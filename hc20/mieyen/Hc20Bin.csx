const int RecordSize = 64;

var name = Args[0];
var address = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var sourceBytes = new byte[0x8000];
int size;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(sourceBytes);
}


var destinationBytes = new List<byte>();
int sum;

void AddByte(int b)
{
    destinationBytes.Add((byte)(b & 0xff));
    sum += b;
}

void AddWord(int w)
{
    var h = (byte)(w >> 8);
    var l = (byte)(w & 0xff);
    AddByte(h);
    AddByte(l);
}

{
    var offset = 0;
    var current = address;
    while (offset < size)
    {
        sum = 0;
        var length = Math.Min(size - offset, RecordSize);
        AddByte(length);
        AddWord(current);
        for (var i = 0; i < length; ++i)
        {
            AddByte(sourceBytes[offset++]);
            ++current;
        }
        AddByte(-sum);
    }
    sum = 0;
    AddByte(0);
    AddWord(address);
    AddByte(-sum);
    AddByte(0);
}

using (var stream = new FileStream(name + ".hc20bin", FileMode.Create, FileAccess.Write))
{
    stream.Write(destinationBytes.ToArray());
}

using (StreamWriter writer = new StreamWriter(new FileStream("EndAddress.txt", FileMode.Create, FileAccess.Write), Encoding.UTF8))
{
    writer.WriteLine(address + size);
}
