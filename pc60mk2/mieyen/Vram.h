constexpr word Vram = 0x0000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 2;
constexpr byte VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
