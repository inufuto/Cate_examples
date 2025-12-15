constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;
constexpr byte VVramStep = 2;
constexpr byte VVramRowSize = VVramWidth * VVramStep;

extern byte[] VVramBack, VVramFront;

extern void VVramBackToFront();
extern void DrawSprite(byte x, byte y, byte pattern);
