constexpr byte VramWidth = 24;
constexpr word VramRowSize = VramWidth * 8;

extern byte[] Vram;
extern byte TopRow;
extern byte CharShift;

extern void PresentVram();
extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c, bool right);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
