constexpr ptr<byte> VramBackO = (ptr<byte>)0x1000;
constexpr ptr<byte> VramFrontO = (ptr<byte>)0x1800;

constexpr byte VramWidth = 25;
constexpr byte VramHeight = 18;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = 32*VramStep;

constexpr byte VramX = (28 - VramWidth) / 2;
constexpr byte VramY = (18 - VramHeight) / 2;
constexpr word VOffset = VramY * VramRowSize + VramX * VramStep;
constexpr ptr<byte> VramBack = VramBackO + VOffset;
constexpr ptr<byte> VramFront = VramFrontO + VOffset;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
