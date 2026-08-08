constexpr byte VVramWidth = 16;
constexpr byte VVramHeight = 12;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
extern ptr<byte> VPut2CXY(byte x, byte y, byte c);
extern ptr<byte> VErase2XY(byte x, byte y);
