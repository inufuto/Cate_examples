constexpr ptr<byte> VicRam = (ptr<byte>)0x8000;
constexpr ptr<byte> Vram = VicRam + 0x400;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
