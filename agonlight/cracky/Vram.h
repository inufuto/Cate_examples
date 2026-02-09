constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth;
constexpr byte CharHeight = 8;

extern byte[] Vram;

extern void ClearScreen();
extern void PresentVram();
extern void SwapScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void EraseBackup(byte x, byte y);

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
