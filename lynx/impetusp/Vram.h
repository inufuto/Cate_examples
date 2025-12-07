constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 17;

constexpr byte VramStep = 3;
constexpr byte VramWidth = 1 + VramStep * WindowWidth + 1;
constexpr byte CharHeight = 6;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr ptr<byte> VramFrontOrg = (ptr<byte>)0xb800;
constexpr ptr<byte> VramBackOrg = (ptr<byte>)0x8e00;
constexpr ptr<byte> VramFront = VramFrontOrg + 1;
constexpr ptr<byte> VramBack = VramBackOrg + 1;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void SwitchPage();
extern void VVramToVram();

extern void DrawAll();
