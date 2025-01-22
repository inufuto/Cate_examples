var name = Args[0];
var begin = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var writer = new StreamWriter("loader.txt", false, Encoding.UTF8))
{
    writer.WriteLine("10 clear 0,{0}", begin);
    writer.WriteLine("20 bload \"cas:\"");
    writer.WriteLine("30 exec {0}", begin);

    writer.WriteLine("csave \"cas:loader\"");
    writer.WriteLine("bsave \"cas:" + name.Substring(0, 6) + ".co\",{0},{1},{0}", begin, size);
}
