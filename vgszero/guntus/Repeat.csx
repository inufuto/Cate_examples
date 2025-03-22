var bgm = new byte[0x2000];
int size;

using (var stream = new FileStream("bgm.bgm", FileMode.Open))
{
    size = stream.Read(bgm);
}

using (var stream = new FileStream("bgm_r.bgm", FileMode.Create))
{
    stream.Write(bgm, 0, size);
    stream.WriteByte(0x90);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);
    stream.WriteByte(0x00);
}