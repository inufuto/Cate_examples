constexpr word Vram_PatternGenerator = 0x0000;
constexpr word Vram_PatternName0 = 0x1800;
constexpr word Vram_PatternName1 = 0x1c00;
constexpr word Vram_SpriteAttribute = 0x1b00;
constexpr word Vram_Color = 0x2000;
constexpr word Vram_SpriteGenerator = 0x3800;

constexpr word Vram = Vram_PatternName0;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;

extern bool BackgroundChanged;
extern word CurrentPage, NextPage;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void StatusToVram();
extern void SwitchVram();
extern word WriteVram(word vram, byte c);

extern void DrawAll();
