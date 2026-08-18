constexpr ptr<byte> Vram = (ptr<byte>)0xc000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;

constexpr byte StageTop = 1;
constexpr byte StageHeight = 23;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern void Put2SXY(byte x, byte y, ptr<byte> pChars);
extern void Put2CXY(byte x, byte y, byte c);
