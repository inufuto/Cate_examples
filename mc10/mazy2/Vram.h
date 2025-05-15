constexpr ptr<byte> Vram = (ptr<byte>)0x4000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 4;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
