var name = Args[0];
var begin = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var writer = new StreamWriter("load.txt", false, Encoding.UTF8))
{
    writer.WriteLine("ob 5 42");
    writer.WriteLine($"l {begin:x}");
    writer.WriteLine();
    writer.WriteLine("ob 5 2");
}
using (var writer = new StreamWriter("run.txt", false, Encoding.UTF8)) 
{
    writer.WriteLine($"clear,&h{begin:x}");
    writer.WriteLine($"a=&h{begin:x}:call a");
}
using (var writer = new StreamWriter("save.txt", false, Encoding.UTF8)) 
{
    writer.WriteLine($"bsave \"cas0:{name}\",{begin},{size}");
}