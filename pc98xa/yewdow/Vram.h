constexpr byte CharHeight = 8;

constexpr word VramOrg = 0x0000;
constexpr byte VramWidth = 70;
constexpr byte VramStep = 2;
constexpr word VramRowSize = VramWidth * CharHeight * 4;
constexpr byte VramLeftX = (VramWidth - 32 * VramStep) / 2;
constexpr byte VramTopY = (750 - CharHeight * 4 * 23) / 2;
constexpr word Vram = VramOrg + VramWidth * VramTopY + VramLeftX;

extern void ClearScreen();
extern word PrintC(word vram, byte c);
extern word Put(word vram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
