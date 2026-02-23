constexpr word Vram = 0x3000;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;

constexpr word VramLeftTop = Vram + (VramWidth - 32) / 2;
constexpr word GVramLeftTop = GVram + (VramWidth - 32) / 2;

constexpr word PatternRam = 0x4000;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 3;

constexpr ptr<byte> SpriteRam = (ptr<byte>)0x2000;

extern void WaitVSync();
extern void SetPcgMono(byte code, ptr<byte> pPattern, byte count, byte color);
extern void SetPcgColor(byte code, ptr<byte> pPattern, byte count);

extern void ClearSpriteRam();
extern void WritePattern(word c, ptr<byte> pSource);
extern void WritePatternH(word c, ptr<byte> pSource);
extern void WritePatternV(word c, ptr<byte> pSource, byte width);
extern void WritePatternHV(word c, ptr<byte> pSource, byte width);
extern void ClearScreen();
extern void WindowBackToVram();
extern void WindowFrontToVram();
extern void GPut1(word gram, word code);
extern void VPut1(word vram, byte c);
extern void VPut2(word vram, byte c);
extern void VErase2(word vram);
extern word PrintC(word vram, byte c);
extern void PlotMarker(word gram, word bytes);

extern void InitVram();
