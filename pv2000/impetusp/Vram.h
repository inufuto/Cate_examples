constexpr word Vram_PatternName0 = 0x1800;
constexpr word Vram_PatternName1 = 0x1c00;

constexpr word Vram = Vram_PatternName0;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StatusHeight = 2;

extern bool BackgroundChanged;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern byte FromAscii(byte c);
extern word PrintC(word vram, byte c);
extern void StatusToVram();
// extern void InitLogo();
extern void SwitchVram();
