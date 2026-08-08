constexpr byte VramHeight = 4;
constexpr byte CharWidth = 4;
constexpr byte VramStep = CharWidth;
constexpr byte VramRowSize = 240/2;
constexpr byte VramWidth = VramRowSize / VramStep;

extern byte[] Vram;

extern void ClearScreen();
extern void PresentVram();
extern ptr<byte> PrintC(ptr<byte> address, byte c);
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> BackupPtr(byte x, byte y);
extern void DrawFence();

extern ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars);
extern void DrawAll();
