constexpr word Vram = 0x0000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight / 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
