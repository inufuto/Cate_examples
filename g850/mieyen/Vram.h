constexpr byte VramRowSize = 144;
constexpr byte CharWidth = 3;
constexpr byte VramStep = 4;
constexpr byte VramHeight = 6;

extern byte[] Vram;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
