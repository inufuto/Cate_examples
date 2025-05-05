constexpr word VramBack = 0x8000;
constexpr word VramFront = 0xa000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
