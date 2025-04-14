constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

extern byte[] VVramBack;
extern byte[] VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern void DrawAll();
extern void VErase2(byte x, byte y);
extern void VPut2(byte x, byte y, byte c);
