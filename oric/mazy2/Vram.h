constexpr byte VramWidth = 40;
constexpr byte VramHeight = 28;
constexpr byte VramStep = VramWidth / 40;
constexpr word VramRowSize = VramWidth * VramStep;

constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight;

constexpr ptr<byte> PatternRam = (ptr<byte>)0xb400;
constexpr ptr<byte> VramBase = (ptr<byte>)0xbb80;
constexpr ptr<byte> Vram = VramBase + VramRowSize;

constexpr byte Color_Black = 0;
constexpr byte Color_Red = 1;
constexpr byte Color_Green = 2;
constexpr byte Color_Yellow = 3;
constexpr byte Color_Blue = 4;
constexpr byte Color_Magenta = 5;
constexpr byte Color_Cyan = 6;
constexpr byte Color_White = 7;

constexpr byte StandardCharset = 8;
constexpr byte AlternateCharset = 9;

extern void ClearScreen();
extern void VVramToVram();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void SetPattern(byte c, byte pattern, byte count);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
