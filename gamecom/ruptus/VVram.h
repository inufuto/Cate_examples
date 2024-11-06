constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24-6;
constexpr byte VVramHeight = 20;

extern bool VVramChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void ClearVVram();

extern void VPutXY(sbyte x, sbyte y, byte c);
extern void VPut6XY(sbyte x, sbyte y, word c);
