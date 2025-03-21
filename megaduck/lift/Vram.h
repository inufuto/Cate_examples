constexpr ptr<byte> Vram = ((ptr<byte>)0x9c00);
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte VramHeight = 18;

constexpr byte WindowWidth = 20;

extern byte HScroll;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void Put2C(ptr<byte> pVram, byte c);
extern void Erase2(ptr<byte> pVram);
extern void Put2CXY(byte x, byte y, byte c);
extern void Erase2XY(byte x, byte y);
