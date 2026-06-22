constexpr word Vram = 0x0000;
constexpr byte VramWidth = 80;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();
