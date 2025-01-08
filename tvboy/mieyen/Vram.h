constexpr ptr<byte> Vram = (ptr<byte>)0x1000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize3 = VramWidth * 3;
constexpr byte VramRowSize2 = VramWidth * 2;
constexpr byte VramRowSize5 = VramWidth * 5;
constexpr byte VramRowSize6 = VramWidth * 6;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> Put3(ptr<byte> pVram, byte c);
extern ptr<byte> Put2(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
