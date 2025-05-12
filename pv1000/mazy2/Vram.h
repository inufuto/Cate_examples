constexpr ptr<byte> Vram = (ptr<byte>)0xb800;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 28;

extern byte XOffset;

extern void ClearScreen();
extern void VVramToVram();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
