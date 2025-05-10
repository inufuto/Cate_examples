constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 2;
constexpr byte CharHeight = 8;
constexpr byte VramAttrWidth = 40;
constexpr byte VramRowSize = VramWidth * VramStep + VramAttrWidth;

constexpr ptr<byte> Vram = ((ptr<byte>)0xf300);

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void VVramToVram();
extern void SetColorXY(byte x, byte y, byte color);

extern void PollVSync();

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
