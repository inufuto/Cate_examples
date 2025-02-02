constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;

constexpr ptr<byte> Vram = (ptr<byte>)0xd000;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = VramHeight;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
