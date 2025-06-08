constexpr ptr<byte> VramOrg = (ptr<byte>)0x4000;
constexpr byte VramWidth = 48;
constexpr byte CharHeight = 8;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr ptr<byte> Vram = VramOrg + VramRowSize * 1;

constexpr byte WindowWidth = 20;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
