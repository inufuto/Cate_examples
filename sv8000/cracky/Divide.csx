var name = Args[0];

var bin = new byte[0x8000];
int binSize;
using (var stream = new FileStream("_.bin", FileMode.Open)) {
    binSize = stream.Read(bin);
}

if (binSize <= 0x4000) {
    using (var stream = new FileStream(name + ".bin", FileMode.Create)) {
        stream.Write(bin, 0x0000, 0x2000);
    }
}
else {
    using (var stream = new FileStream(name + "_0.bin", FileMode.Create)) {
        stream.Write(bin, 0x0000, 0x2000);
    }
    using (var stream = new FileStream(name + "_1.bin", FileMode.Create)) {
        stream.Write(bin, 0x4000, 0x2000);
    }
    using (var stream = new FileStream(name + ".bin", FileMode.Create)) {
        stream.Write(bin, 0x0000, 0x2000);
        stream.Write(bin, 0x4000, 0x2000);
    }
    using (var writer = new StreamWriter("contents.txt", false, Encoding.ASCII)) {
        writer.WriteLine($"{name}_0.bin : 0x0000-0x1fff");
        writer.WriteLine($"{name}_1.bin : 0x4000-0x5fff");
        writer.WriteLine($"{name}.bin : Appended above 0x4000 for emulator");
    }
}