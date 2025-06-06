constexpr byte VramWidth = 24;
constexpr byte VramHeight = 16;
constexpr byte CharWidth = 4;
constexpr byte VramStep = CharWidth;
constexpr byte VramRowSize = VramWidth * VramStep;

extern byte[] Vram;

constexpr byte WindowWidth = 23;
constexpr byte WindowHeight = 14;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PutU(ptr<byte> pVram, byte c);
extern ptr<byte> PutL(ptr<byte> pVram, byte c);
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
