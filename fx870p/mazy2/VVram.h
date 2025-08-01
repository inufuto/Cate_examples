constexpr byte VVramWidth = 19;
constexpr byte VVramHeight = 13;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
