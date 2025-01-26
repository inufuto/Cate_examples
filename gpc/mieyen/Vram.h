constexpr byte VramRowSize = 75;
constexpr byte VramHeight = 8;
constexpr byte CharWidth = 3;
constexpr byte VramStep = 4;
constexpr ptr<byte> Vram = (ptr<byte>)0xc000;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PutU(ptr<byte> pVram, byte c);
extern ptr<byte> PutL(ptr<byte> pVram, byte c);
extern void VVramToVram();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
