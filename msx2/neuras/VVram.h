constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut2C(ptr<byte> pVVram, byte c);
extern void VErase2(ptr<byte> pVVram);
extern void VPut2CXY(byte x, byte y, byte c);
extern void VErase2XY(byte x, byte y);
