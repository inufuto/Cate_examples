constexpr word Vram = 0x8000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth * CharHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();