constexpr word Vram = 0xc000;

constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;

constexpr word VramLeftTop = Vram + VramWidth / 2 - 32;

constexpr byte PatternSize = CharHeight * 3 * 2;

extern void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
extern void MakePatternColor(byte c, ptr<byte> pSource, byte count);
extern void ClearScreen();
extern void VPut1(word vram, byte c);
extern void WindowToVramAll();
extern void WindowToVramChanged();
extern void PlotMarker(word vram, byte b);

extern void InitVram();
extern word PrintC(word vram, byte c);
extern void VPut2(word vram, byte c);
extern void VErase2(word vram);
