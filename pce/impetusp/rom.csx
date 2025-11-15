private const int PageSize = 0x2000;

var name = Args[0];

var bytes = new byte[0x10000];
int size;
using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var stream = new FileStream(name + ".pce", FileMode.Create, FileAccess.Write))
{
    if (size > PageSize) {
        stream.Write(bytes, size - PageSize, PageSize);
        stream.Write(bytes, 0, size - PageSize);
    }
    else {
        stream.Write(bytes);
    }
}
