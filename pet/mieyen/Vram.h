constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth;

constexpr ptr<byte> Vram = (ptr<byte>)0x8000;

constexpr byte Char_Space = 0x20;

extern void ClearScreen();
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c);

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
