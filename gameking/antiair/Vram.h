constexpr byte CharHeight = 2;
constexpr byte VramWidth = 48 / 4;
constexpr byte VramHeight = 32 / CharHeight;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte Char_Space = 0;

extern byte[] Vram, StatusPane;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 16 - 2;

extern bool BackgroundChanged;

extern ptr<byte> VramPtr(byte x, byte y);
extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c, bool right);
extern void PresentVram();

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars, bool right);
extern void DrawAll();
