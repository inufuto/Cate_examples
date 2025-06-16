constexpr word Vram_PatternGenerator = 0x0000;
constexpr word Vram_Color = 0x2000;
constexpr word Vram_PatternName0 = 0x4000;
constexpr word Vram_PatternName1 = 0x4400;
constexpr word Vram_SpriteColor = 0x5c00;
constexpr word Vram_SpriteAttribute = 0x5e00;
constexpr word Vram_SpriteGenerator = 0x7800;

constexpr word Vram = Vram_PatternName0;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24+1;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte CharHeight = 8;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = VramWidth;
constexpr byte WindowHeight = VramHeight - 2;

extern byte VScroll;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern void MapToVram();

extern word PrintC(word vram, byte c);
