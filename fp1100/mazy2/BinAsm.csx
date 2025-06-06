var name = Args[0];
private static Dictionary<string, string> symbols = new Dictionary<string, string>();
private static string startAddress;

private static string ToHex(string s)
{
    if (!char.IsDigit(s.ToCharArray()[0]))
    {
        s = "0" + s;
    }
    return s + "h";
}

private static string ToHex(int value)
{
    return ToHex($"{value:x}");
}

private static void ReadSymbols(string fileName)
{
    using var reader = new StreamReader(fileName, Encoding.UTF8);
    reader.ReadLine();
    reader.ReadLine();
    var line = reader.ReadLine();
    while (!string.IsNullOrEmpty(line))
    {
        var columns = line.Split(" ", StringSplitOptions.RemoveEmptyEntries);
        symbols[columns[0]] = columns[1];
        line = reader.ReadLine();
    }
    line = reader.ReadLine();
    if (line != null)
    {
        startAddress = line.Substring(5, 4);
    }
}


ReadSymbols(name + ".symbols.txt");

var size = 0;
using (var writer = new StreamWriter(name + "Bin.asm"))
{
    writer.WriteLine("cseg");
    writer.WriteLine(name + "Bin: public " + name + "Bin");

    using (var stream = new FileStream(name + ".bin", FileMode.Open, FileAccess.Read))
    {
        var i = 0;
        var b = stream.ReadByte();
        while (b >= 0)
        {
            ++size;
            writer.Write(i == 0 ? "\tdefb\t" : ",");
            writer.Write(ToHex(b));
            if (++i == 8)
            {
                writer.WriteLine();
                i = 0;
            }
            b = stream.ReadByte();
        }
    }
}

using (var writer = new StreamWriter(name + "Bin.inc"))
{

    writer.WriteLine(name + "_start equ " + ToHex(startAddress));
    writer.WriteLine(name + "_size equ " + size);
    foreach (var pair in symbols)
    {
        writer.WriteLine(pair.Key + " equ " + ToHex(pair.Value));
    }
}
