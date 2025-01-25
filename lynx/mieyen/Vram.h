constexpr byte VramWidth = 80;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 6;
constexpr byte VramStep = 3;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr ptr<byte> BackgroundOrg = (ptr<byte>)0x9900;
constexpr ptr<byte> Page0Org = (ptr<byte>)0xb800;
constexpr ptr<byte> Page1Org = (ptr<byte>)0xdc00;
constexpr ptr<byte> Background = BackgroundOrg + 1;
constexpr byte BackgroundHeight = 16;

constexpr ptr<byte> Vram = Background;
constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern void SwitchPage();

extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
extern void DrawAll();
