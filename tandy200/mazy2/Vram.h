constexpr word Vram = 0;
constexpr byte VramWidth = 30;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr byte WindowWidth = 23;
constexpr byte WindowHeight = 16;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
