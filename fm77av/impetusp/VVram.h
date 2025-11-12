constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

extern byte[] VVramBack, VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void ClearVVramFront();

