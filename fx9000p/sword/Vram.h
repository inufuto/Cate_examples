constexpr ptr<byte> Vram = ((ptr<byte>)0x7fff);
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 16;
constexpr byte CharHeight = 8;
constexpr byte VramStep = -CharHeight;
constexpr byte VramRowSize = VramWidth * VramStep;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);