constexpr ptr<byte> Vram = (ptr<byte>)0x4000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte VramStep = VramWidth / 40;

extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern void BeginDraw();
extern void EndDraw();
extern void DrawSprite(byte x, byte y, byte pattern);

extern ptr<byte> Put2C(ptr<byte> pVram, byte c);
extern ptr<byte> Erase2(ptr<byte> pVram);
    