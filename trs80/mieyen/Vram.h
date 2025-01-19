constexpr byte VramWidth = 64;
constexpr byte VramHeight = 16;
constexpr word VramRowSize = VramWidth;
constexpr ptr<byte> Vram = (ptr<byte>)0x3c00;
constexpr byte VramStep = 1;
constexpr byte Char_Space = 0;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void VVramToVram();

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
extern ptr<byte> Erase2(ptr<byte> pVram);
