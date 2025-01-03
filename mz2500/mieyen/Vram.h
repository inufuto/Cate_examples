constexpr ptr<byte> Vram = (ptr<byte>)0xe000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte CharHeight = 8;
constexpr word VramRowSize = VramWidth * VramStep;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void EraseSprite(byte x, byte y, byte pattern);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchGVram();
extern byte ReadVram(ptr<byte> pVram);

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
