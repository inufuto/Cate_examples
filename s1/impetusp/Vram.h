constexpr ptr<byte> Vram = (ptr<byte>)0x2000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = 25;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite1(byte x, byte y, byte pattern);
extern void DrawSprite2(byte x, byte y, byte pattern);
extern void SwitchGVram();
extern void SwitchTVram();

extern void DrawAll();
