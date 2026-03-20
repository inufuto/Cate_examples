constexpr ptr<byte> VramOrg = (ptr<byte>)0xf000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 26;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr ptr<byte> Vram = VramOrg + VramRowSize * 0;

constexpr byte StatusHeight = 2;
constexpr byte WindowTop = StatusHeight;
constexpr byte WindowWidth = VramWidth;
constexpr byte WindowHeight = VramHeight - StatusHeight - 1;

extern bool BackgroundChanged;
extern ptr<byte> pNextPage;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void ClearPage();
extern void SwitchPage();

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
