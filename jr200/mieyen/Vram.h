constexpr ptr<byte> Vram = (ptr<byte>)0xc100;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramSize = VramWidth * VramHeight;
constexpr byte PatternSize = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StatusHeight = 2;

extern void SetPattern(byte c, byte pattern, byte count);
extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte color);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c, byte color);
