constexpr ptr<byte> Vram = ((ptr<byte>)0x7fff);
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 8;
constexpr byte VramStep = -CharHeight;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte TopMargin = 2;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
