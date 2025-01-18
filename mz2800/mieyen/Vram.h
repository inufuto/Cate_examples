constexpr word Vram = 0;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 4;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * VramStep;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word VramAddress(byte x, byte y);
extern void SwitchVram();
extern void DrawSprite(byte x, byte y, byte pattern);
extern void EraseSprite(byte x, byte y);
extern byte ReadVram(word vram);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern word Put2S(word vram, ptr<byte> pChars);
extern void DrawFrontAll();
