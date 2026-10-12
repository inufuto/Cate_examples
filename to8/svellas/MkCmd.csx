const int FileNameLength = 8;

var name = Args[0];
var fileName = name.ToUpper().Substring(0, Math.Min(name.Length, FileNameLength));

var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream(name + ".bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}
var topAddress = int.Parse(Args[1], System.Globalization.NumberStyles.HexNumber);
var tailAddress = topAddress + binSize - 1;

using (var writer = new StreamWriter("cmd.txt", false, Encoding.ASCII))
{
    writer.WriteLine($"10 LOADM \"{fileName}\",,R");
    writer.WriteLine("SAVE \"AUTO.BAT\"");
    writer.WriteLine($"SAVEM \"{fileName}\",&H{topAddress:X4},&H{tailAddress:X4},&h{topAddress:X4}");
    writer.WriteLine($"REM load \"{Path.GetFullPath(name + ".bin")}\",{topAddress:X4}");
    writer.WriteLine($"REM {topAddress:X4} - {tailAddress:X4}");
}
