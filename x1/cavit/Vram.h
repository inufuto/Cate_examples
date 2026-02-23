constexpr word Vram = 0x3000;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;

constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 3;

constexpr byte TopY = 1;
constexpr word VramTop = Vram + VramWidth * TopY;
constexpr word GVramTop = GVram + VramWidth * TopY;

extern void WaitVSync();
extern void SetPcgMono(byte code, ptr<byte> pPattern, byte color, byte count);
extern void SetPcgColor(byte code, ptr<byte> pPattern, byte count);

extern void ClearScreen();
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern void VPut(word vram, byte c);
extern word PrintC(word vram, byte c);
extern word VramAddress(byte x, byte y);

extern void InitVram();
