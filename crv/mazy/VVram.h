constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 24;
constexpr word VVramSize = VVramWidth * VVramHeight;

extern word VVramAddress(byte x, byte y);
extern void MapToVVram();

extern void VPut1(sbyte x, sbyte y, byte c);
extern void VPut2(sbyte x, sbyte y, byte c);
