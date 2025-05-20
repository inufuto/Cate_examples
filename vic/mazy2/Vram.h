constexpr byte VramWidth = 24;
constexpr byte VramHeight = 24;

constexpr ptr<byte> Vram = (ptr<byte>)0x1000;
constexpr ptr<byte> PatternRam = (ptr<byte>)0x1400;
constexpr ptr<byte> ColorMap = (ptr<byte>)0x9400;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth;
constexpr byte PatternSize = 8;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void VVramToVram();

extern void PrintC(byte c);
extern void EndPrint();
extern void Locate(ptr<byte> pVram);
extern void CurrentChar(byte c);

extern void LocatePattern(ptr<byte> pVram, byte xMod, byte c);
extern void PutPattern(byte pattern);
extern void SetSpriteColor(byte sprite, byte color);
extern void PutColor(ptr<byte> pVram, byte color, byte count);

extern void Put2C(ptr<byte> pVram, byte c, byte pattern, byte color);
