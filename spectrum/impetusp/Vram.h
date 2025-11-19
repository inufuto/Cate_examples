constexpr word Vram = 0;

constexpr byte VramWidth = 32;
// constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern byte FromAscii(byte c);
extern word PrintC(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);
extern void StatusToSpriteLayer();

extern void DrawAll();
