constexpr byte VramWidth = 16;
constexpr byte CharHeight = 4;
constexpr word VramRowSize = VramWidth * CharHeight;
constexpr word Vram = 0;

extern void ClearScreen();
extern word Put(word vram, byte c, bool right);
extern void VVramToVram();
extern word PrintC(word vram, byte c, bool right);

extern void DrawAll();
extern word Put2C(word vram, byte c, bool right);
extern word Erase2(word vram, bool right);
