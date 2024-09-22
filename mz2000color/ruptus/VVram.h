constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;

extern void ClearVVram();
extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);
