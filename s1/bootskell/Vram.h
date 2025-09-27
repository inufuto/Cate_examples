constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr word Vram = 0x2000;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchGVram();

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);
extern void Put2S(word vram, ptr<byte> pChars);
extern void Erase2(word vram);
extern void Put2CXY(byte x, byte y, byte c);
extern void Put2SXY(byte x, byte y, ptr<byte> pChars);
