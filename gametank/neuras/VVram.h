constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut2(ptr<byte> pVVram, byte c);
extern void VPut2XY(byte x, byte y, byte c);
extern void VErase2(ptr<byte> pVVram);
extern void VErase2XY(byte x, byte y);
