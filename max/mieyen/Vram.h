constexpr ptr<byte> VicRam = (ptr<byte>)0x0000;
constexpr ptr<byte> Vram = VicRam + 0x400;
constexpr ptr<byte> ColorMap = (ptr<byte>)0xd800;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight;
constexpr byte SpriteSize = 64;
constexpr byte VramStep = 1;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
