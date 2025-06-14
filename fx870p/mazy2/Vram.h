constexpr byte VramHeight = 4;
constexpr byte AsciiWidth = 4;
constexpr byte VramStep = 3;
constexpr byte VramRowSize = 240/2;

extern byte[] Vram;
extern byte TopRow;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
