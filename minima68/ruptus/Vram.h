constexpr ptr<byte> VramOrg = (ptr<byte>)0xf000;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr ptr<byte> Vram = VramOrg + VramRowSize * 1;

constexpr byte WindowWidth = VramWidth - 8;
constexpr byte WindowHeight = VramHeight;

extern ptr<byte> pNextPage;
extern bool BackgroundChanged;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void SwitchPage();
extern void ClearPage();

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern ptr<byte> Put4S(ptr<byte> pVram, ptr<byte> pChars);
extern void Write1(sbyte x, sbyte y, byte c);
extern void Write6(sbyte x, sbyte y, byte c);