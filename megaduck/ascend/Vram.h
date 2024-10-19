constexpr ptr<byte> Vram = ((ptr<byte>)0x9c00);
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte VramHeight = 18;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 20;
constexpr byte WindowHeight = 18 - 1;

extern byte VScroll, HScroll;
extern ptr<byte> pCurrentPage, pNextPage;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void SwitchPage();
extern ptr<byte> WriteVram(ptr<byte> pVram, byte c);
extern void UpdateOffset();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void Put2C(ptr<byte> pVram, byte c);
