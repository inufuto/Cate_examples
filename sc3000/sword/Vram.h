constexpr word Vram_PatternGenerator = 0x0000;
constexpr word Vram_PatternName = 0x1800;
constexpr word Vram_SpriteAttribute = 0x1b00;
constexpr word Vram_Color = 0x2000;
constexpr word Vram_SpriteGenerator = 0x3800;

constexpr word Vram = Vram_PatternName;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);

extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern word Put2CXY(byte x, byte y, byte c);
extern word Erase2XY(byte x, byte y);
