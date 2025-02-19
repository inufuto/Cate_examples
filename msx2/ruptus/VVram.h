constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 24;

extern bool VVramChanged;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut1(sbyte x, sbyte y, byte c);
extern void VPut6(sbyte x, sbyte y, byte c);
