constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * CharHeight;

constexpr ptr<byte> Vram = (ptr<byte>)0x6000;

extern void ClearScreen();
extern void VPut(ptr<byte> pVram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
