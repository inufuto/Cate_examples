constexpr byte VramWidth = 32;
constexpr byte VramHeight = 16;
constexpr word VramRowSize = VramWidth;

constexpr ptr<byte> VramO = (ptr<byte>) 0x7e00;
constexpr ptr<byte> Vram = VramO + (VramWidth - 24) / 2;
constexpr byte Char_Space = 0x20;
constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
extern ptr<byte> Erase2(ptr<byte> pVram);
