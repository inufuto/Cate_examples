constexpr byte VramWidth = 32;
constexpr byte VramHeight = 16;
constexpr byte VramStep = 1;
constexpr word VramRowSize = VramWidth;

constexpr ptr<byte> Vram = (ptr<byte>) 0x7e00;

constexpr byte Char_Space = 0x20;

extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern void DrawAll();
extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
extern ptr<byte> Erase2(ptr<byte> pVram);