constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth;

constexpr ptr<byte> Vram = (ptr<byte>)0xd000;

extern void ClearScreen();
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
