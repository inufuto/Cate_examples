constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * CharHeight;

constexpr ptr<byte> Vram = (ptr<byte>)0x6000;

extern void ClearScreen();
extern void WindowToVramAll();
extern void WindowToVramChanged();

extern void VPut2(ptr<byte> pVram, byte c);
extern void VErase2(ptr<byte> pVram);
extern void VPut2(ptr<byte> pVram, byte c);
extern void VPut4(ptr<byte> pVram, ptr<byte> pChars);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
