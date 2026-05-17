constexpr byte VVramWidth = 20;
constexpr byte VVramHeight = 14;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
