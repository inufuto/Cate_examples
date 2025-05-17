constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;

constexpr word Vram = 0x2000;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchGVram();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
