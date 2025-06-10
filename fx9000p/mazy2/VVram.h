constexpr byte VVramWidth = 25;
constexpr byte VVramHeight = 16;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
