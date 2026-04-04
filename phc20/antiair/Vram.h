constexpr byte VramWidth = 16;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize3 = VramWidth * 3;
constexpr byte VramRowSize2 = VramWidth * 2;
constexpr byte VramRowSize5 = VramWidth * 5;
constexpr byte VramRowSize6 = VramWidth * 6;

constexpr ptr<byte> Vram = (ptr<byte>)0x4000;

extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put3L(ptr<byte> pVram, byte c);
extern ptr<byte> Put3R(ptr<byte> pVram, byte c);
extern ptr<byte> Put2L(ptr<byte> pVram, byte c);
extern ptr<byte> Put2R(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
