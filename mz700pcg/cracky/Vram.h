constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;

constexpr ptr<byte> Vram = (ptr<byte>)0xd000;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVramAll();
extern void VVramToVramChanged();

extern void Put2C(ptr<byte> pVram, byte c);
