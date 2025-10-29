private const int HeadByte = 0x3a;
private const int MaxRecordSize = 0xff;

var name = Args[0];

var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream("~" + name + ".bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}

using (var stream = new FileStream(name + ".cmt", FileMode.Create)) {
    {
        var address = 0x8100;
        byte low = (byte)address;
        byte high = (byte)(address >> 8);
        int sum = low + high;
        stream.WriteByte(HeadByte);
        stream.WriteByte(high);
        stream.WriteByte(low);
        stream.WriteByte((byte)(-sum & 0xff));
    }

    var offset = 0;
    while (offset < binSize) {
        var recordSize = Math.Min(MaxRecordSize, bin.Length - offset);

        stream.WriteByte(HeadByte);
        stream.WriteByte((byte)recordSize);
        var sum = recordSize;
        for (var i = 0; i < recordSize; ++i) {
            var b = bin[offset + i];
            stream.WriteByte(b);
            sum += b;
        }
        stream.WriteByte((byte)(-sum & 0xff));

        offset += recordSize;
    }
    stream.WriteByte(HeadByte);
    stream.WriteByte(0);
    stream.WriteByte(0);
}
