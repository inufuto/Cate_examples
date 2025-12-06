constexpr ptr<byte> VramBackOrg = (ptr<byte>)0x1000;
constexpr ptr<byte> VramFrontOrg = (ptr<byte>)0x1800;

constexpr byte VramWidth = 24;
constexpr byte VramHeight = 18;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = 32 * VramStep;

constexpr byte VramX = (28 - VramWidth) / 2;
constexpr byte VramY = (18 - VramHeight) / 2;
constexpr word VOffset = VramY * VramRowSize + VramX * VramStep;
constexpr ptr<byte> VramBack = VramBackOrg + VOffset;
constexpr ptr<byte> VramFront = VramFrontOrg + VOffset;

extern bool BackgroundChanged;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();
