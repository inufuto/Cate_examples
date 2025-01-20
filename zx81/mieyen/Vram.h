constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramRowSize = VramWidth+1;
constexpr byte VramStep = 1;

extern byte[] Vram;
extern bool BackgroundChanged;

constexpr byte Char_Space = 0;
constexpr byte StatusHeight = 2;

extern ptr<byte> pCurrentPage;

extern void SwitchPage();
extern void ClearScreen();
extern ptr<byte> Put(ptr<byte> pVram, byte c);
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> VramPtr(byte x, byte y);

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
extern void DrawAll();
