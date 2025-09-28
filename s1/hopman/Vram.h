constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr ptr<byte> Vram = (ptr<byte>)0x2000;

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = 25;

extern bool BackgroundChanged;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void EraseSprite(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void SwitchGVram();
extern ptr<byte> CurrentPage();
extern ptr<byte> NextPage();
extern void SwitchTVram();
extern void MapToVram();

extern void DrawAll();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);