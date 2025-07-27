constexpr word Vram = 0x8000;

constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = CharHeight * 2;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = VramHeight;

extern void InitAsciiPattern();
extern void InitMonoPattern();
extern void InitColorPattern();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();
extern word PrintC(word vram, byte c);

extern void InitVram();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
