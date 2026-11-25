constexpr word Vram = 0;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * 8 * 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void Put2C(word vram, byte c);
