constexpr byte VVramWidth = WindowWidth;
constexpr byte VVramHeight = WindowHeight;

extern byte[] VVramBack, VVramFront;
extern bool BackgroundChanged;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVram, byte c);
