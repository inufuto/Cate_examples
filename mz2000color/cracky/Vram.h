constexpr word Vram = 0xc000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte VramStep = 2;

extern void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
extern void MakePatternColor(byte c, ptr<byte> pSource, byte count);
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void InitVram();
extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);
