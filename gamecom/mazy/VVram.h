constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24 - 6;
constexpr byte VVramHeight = 20;
constexpr word VVramSize = VVramWidth * VVramHeight;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();

extern void VPut1(sbyte x, sbyte y, byte c);
extern void VPut2(sbyte x, sbyte y, byte c);
