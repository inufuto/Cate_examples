constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;
extern byte[3] RowFlags;

extern void ClearVVram();
extern void VVramBackToFront();
extern void SetRowFlag(byte y);
extern void SetRowFlag2(byte y);
extern word VVramOffset(byte x, byte y);
// extern void Put1(sbyte x, sbyte y, byte c);
// extern void Put6(sbyte x, sbyte y, byte c);