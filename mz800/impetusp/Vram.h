constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr word Vram = 0x8000;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
