constexpr byte VramWidth = 40;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = CharHeight;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr ptr<byte> VramOrg = (ptr<byte>)0x5800;
constexpr ptr<byte> Vram = VramOrg + VramRowSize * 3;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void VVramToVram();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
