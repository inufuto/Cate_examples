constexpr ptr<byte> VramOrg = (ptr<byte>)0xf000;
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr ptr<byte> Vram = VramOrg + VramRowSize;

constexpr byte StatusHeight = 2;
constexpr byte VramHeight = 25;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
