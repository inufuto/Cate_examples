constexpr ptr<byte> VicRam = (ptr<byte>)0x8000;
constexpr ptr<byte> Vram = VicRam + 0x400;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

extern bool BackgroundChanged;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern void DrawAll();
