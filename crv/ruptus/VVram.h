constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 24;

extern bool VVramChanged;

extern void ClearVVram();
extern word VVramAddress(byte x, byte y);

extern void VPutXY(sbyte x, sbyte y, byte c);
extern void VPut6CXY(sbyte x, sbyte y, byte c);
extern void VVramToVram();
