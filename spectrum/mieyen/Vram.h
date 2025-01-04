constexpr word Vram = 0;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
