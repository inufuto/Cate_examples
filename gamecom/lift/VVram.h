constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void ClearVVram();

extern void VPut2CXY(byte x, byte y, byte c);
extern void VErase2XY(byte x, byte y);