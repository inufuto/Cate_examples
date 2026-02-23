constexpr word TVram = 0x3000;
constexpr word Attributes = 0x2000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;

constexpr byte CharHeight = 8;
constexpr byte VramStep = 2;
constexpr byte PatternSize = CharHeight * 3;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = VramHeight;

extern void InitVram();

extern void InitAsciiPcg();
extern void InitMonoPattern();
extern void InitColorPattern();
extern void InitColorPcg();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern void GVVramToVramAll();
extern void GVVramToVramChanged();
extern word PrintC(word vram, byte c);
extern void TVVramToVram();

extern void InitVram();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
