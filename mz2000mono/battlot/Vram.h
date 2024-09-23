constexpr word Vram = 0xc000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern void VPut(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern word PrintC(word vram, byte c);
