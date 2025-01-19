constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr ptr<byte> Vram = (ptr<byte>)0x0100;

constexpr byte Char_Space = 0;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c);

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
