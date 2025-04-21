constexpr ptr<byte> Vram = (ptr<byte>)0xc000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;

constexpr ptr<byte> VramTop = Vram + VramRowSize;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> VramPtr(byte x, byte y);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern void Put2CXY(byte x, byte y, byte c);
extern void Erase2XY(byte x, byte y);
