constexpr byte VVramWidth = 18;
constexpr byte VVramHeight = 16;
constexpr word VVramSize = VVramWidth * VVramHeight;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();

extern void VPut1(sbyte x, sbyte y, byte c);
extern void VPut2(sbyte x, sbyte y, byte c);
