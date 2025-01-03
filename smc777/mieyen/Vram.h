constexpr word Vram = 0x8000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramCellSize = 4;
constexpr byte VramStep = VramCellSize;
constexpr byte VramRowSize = VramWidth * VramCellSize;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
