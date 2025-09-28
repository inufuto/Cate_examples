constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr word Vram = 0x2000;

constexpr byte StageWidth = 32;
constexpr byte StageHeight = 25;

extern bool BackgroundChanged;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchGVram();
extern word WriteTVram(word vram, byte c);
extern word CurrentPage();
extern word NextPage();
extern void SwitchTVram();
extern void DrawGround();

extern void DrawAll();
extern word PrintC(word vram, byte c);
