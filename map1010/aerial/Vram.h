constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr word VramRowSize = VramWidth * CharHeight;
constexpr byte StatusHeight = 2;

constexpr ptr<byte> Vram = (ptr<byte>)0x6000;

extern void ClearScreen();
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
