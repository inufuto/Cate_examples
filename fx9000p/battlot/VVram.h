constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern ptr<byte> WallMapPtr(byte x, byte y);
