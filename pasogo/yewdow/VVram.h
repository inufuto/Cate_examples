constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = 22;
constexpr byte VVramWidth = WindowWidth + 2;
constexpr byte VVramHeight = WindowHeight + 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
extern void VPut2CXY(byte x, byte y, byte c);
extern void VErase2XY(byte x, byte y);
