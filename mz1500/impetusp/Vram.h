constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = CharHeight * 3;
constexpr byte VramRowSize = VramWidth;
constexpr byte VramStep = 1;

constexpr ptr<byte> Vram = (ptr<byte>)0xd400;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
