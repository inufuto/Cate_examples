constexpr word Vram = 0x3000;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;

constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte PatternSize = CharHeight * 3;

constexpr byte WindowWidth = 32;
constexpr byte StageTop = 4;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
