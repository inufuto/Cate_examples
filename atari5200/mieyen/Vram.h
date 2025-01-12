constexpr ptr<byte> Vram = (ptr<byte>)0x1400;
constexpr ptr<byte> CharRam = (ptr<byte>)0x1000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight;
constexpr word VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
