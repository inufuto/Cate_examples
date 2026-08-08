constexpr byte VramHeight = 4;
constexpr byte CharWidth = 4;
constexpr byte VramStep = CharWidth;
constexpr byte VramRowSize = 240/2;
constexpr byte VramWidth = VramRowSize / VramStep;

extern byte[] Vram;
constexpr byte WindowWidth = 24;
constexpr byte WindowHeight = 16+2;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PrintC(ptr<byte> address, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();
extern void DrawFence();

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
