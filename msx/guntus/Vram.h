constexpr word Vram_PatternGenerator = 0x0000;
constexpr word Vram_PatternGenerator2 = 0x0800;
constexpr word Vram_PatternName = 0x1800;
constexpr word Vram_SpriteAttribute = 0x1b00;
constexpr word Vram_PatternName2 = 0x1c00;
constexpr word Vram_Color = 0x2000;
constexpr word Vram_SpriteGenerator = 0x3800;

constexpr word Vram = Vram_PatternName;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte StatusHeight = 2;

constexpr byte WindowWidth = VramWidth - 6;
constexpr byte WindowHeight = VramHeight;

extern bool BackgroundChanged;

extern void InitVram();
extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);

extern void ClearBackgound();
extern word OffPut(word vram, byte c);
extern void SwitchVram();
extern void UpdateEnemyChars();
extern void SwitchChars();
extern word ForegoundAddress();
extern word BackgoundAddress();
extern void WriteVram(word vram, byte c);
extern byte ReadVram(word vram);
extern void EnemyRowsToVram(word vram, ptr<byte> pSource, byte width);

extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
