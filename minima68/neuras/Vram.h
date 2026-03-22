constexpr ptr<byte> VramOrg = (ptr<byte>)0xf000;
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr ptr<byte> Vram = VramOrg + VramRowSize;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern void Erase2(ptr<byte> pVram);
extern void Put2CXY(byte x, byte y, byte c);
extern void Erase2XY(byte x, byte y);
