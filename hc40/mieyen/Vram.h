constexpr ptr<byte> Vram = (ptr<byte>)0xe000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 8 * 2;
constexpr byte CharHeight = 4;
constexpr byte AsciiHeight = CharHeight * 2;
constexpr word VramRowSize = VramWidth * CharHeight;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c, bool right);
