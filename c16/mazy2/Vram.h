constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight;
constexpr word VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr ptr<byte> Vram = (ptr<byte>)0x0C00;
constexpr ptr<byte> ColorMap = (ptr<byte>)0x0800;
constexpr ptr<byte> PatternRam = (ptr<byte>)0x1000;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
