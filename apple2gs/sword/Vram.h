constexpr word Vram = 0x2000;
constexpr byte VramStep = 4;
constexpr byte VramWidth = VramStep * 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * CharHeight;

constexpr byte WindowWidth = 32;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
