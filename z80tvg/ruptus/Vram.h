constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

extern byte[] Vram;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = VramHeight;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void PresentVram();
extern void VVramToVram();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
