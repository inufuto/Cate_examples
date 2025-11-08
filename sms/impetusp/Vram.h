constexpr word Vram_PatternGenerator = 0x0000;
constexpr word Vram_PatternName0 = 0x1800;
constexpr word Vram_PatternName1 = 0x3800;
constexpr word Vram_SpriteAttribute = 0x3f00;

constexpr word Vram = Vram_PatternName0;

constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 4;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern byte FromAscii(byte c);
extern word PrintC(word vram, byte c);
extern void StatusToVram();
extern void SwitchVram();
