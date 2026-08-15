constexpr word VramBack = 0x8000;
constexpr word VramFront = 0xa000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr byte StageTopY = 1;
constexpr byte StageHeight = 23;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern word VramAddress(byte x, byte y);

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void Put2CXY(byte x, byte y, byte c);
extern void Put2SXY(byte x, byte y, ptr<byte> pChars);
