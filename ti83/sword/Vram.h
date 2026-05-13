constexpr ptr<byte> Vram = (ptr<byte>)0x9340;
constexpr byte VramWidth = 12;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 4;
constexpr byte AsciiHeight = CharHeight * 2;
constexpr word VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
extern void VVramToVram();

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c, bool right);
extern ptr<byte> Erase2(ptr<byte> pVram, bool right);
