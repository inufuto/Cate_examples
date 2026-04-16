constexpr word Vram = 0x3000;
constexpr word GVram = 0x4000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StageTop = 2;
constexpr byte StageWidth = 32;
constexpr byte StageHeight = 22;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchVram();

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);

extern void PollVSync();