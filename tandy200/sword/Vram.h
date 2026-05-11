constexpr word Vram = 0;
constexpr byte VramWidth = 30;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
