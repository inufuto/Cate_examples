constexpr word Vram = 0;
constexpr byte VramWidth = 40;
// constexpr byte VramHeight = 25;
constexpr byte VramStep = 4;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * VramStep;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = 25;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void SwitchTVram();
extern void SwitchGVram();
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
