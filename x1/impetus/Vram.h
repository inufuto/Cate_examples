constexpr word Vram = 0x3000;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;

constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 3;

extern void InitVram();

extern void SetPcgMono(byte code, ptr<byte> pPattern, byte color, byte count);
extern void SetPcgColor(byte code, ptr<byte> pPattern, byte count);
extern void SetPcgHalf(byte code, ptr<byte> pUpper, ptr<byte> pLower);
extern void ClearScreen();
extern void ToGVram();
extern void VPut(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void ToVramAll();
extern void ToVramChanged();

extern void InitVram();
