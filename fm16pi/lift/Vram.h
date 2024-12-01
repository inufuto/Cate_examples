constexpr word Vram = 0x0000;

constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * CharHeight * VramStep;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern word PrintC(word vram, byte c);
extern void DrawAll();
extern void Put2C(word vram, byte c);
