constexpr word Vram = 0x0000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = VramHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
