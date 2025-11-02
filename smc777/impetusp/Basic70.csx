var name = Args[0];
var begin = int.Parse(Args[1], System.Globalization.NumberStyles.AllowHexSpecifier);

var bytes = new byte[0x8000];
int size;

using (var stream = new FileStream(name + "_t.bin", FileMode.Open, FileAccess.Read))
{
    size = stream.Read(bytes);
}

using (var writer = new StreamWriter("loader.txt", false, Encoding.UTF8))
{
    var lineNum=10;
    writer.WriteLine($"{lineNum} a={begin}"); lineNum +=10;
    writer.WriteLine($"{lineNum} call a"); lineNum +=10;
    writer.WriteLine($"csave \"{name}\",{begin},{begin+size-1}");
}
