constexpr ptr<byte> BgNameTable = (ptr<byte>)0x8000;
constexpr ptr<byte> FgNameTable = (ptr<byte>)0x8800;

constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr ptr<byte> VramBack = BgNameTable + VramRowSize;
constexpr ptr<byte> VramFront = FgNameTable + VramRowSize;
constexpr byte VramHeight = 24;

extern bool BackgroundChanged;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern word VramOffset(byte x, byte y);
extern void VVramToVram();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern void DrawAll();
