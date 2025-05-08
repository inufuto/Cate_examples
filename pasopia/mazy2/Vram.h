constexpr word Vram = 1;

constexpr byte VramWidth = 81;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern word PrintC(word vram, byte c);

extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
