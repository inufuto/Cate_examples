constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;
constexpr byte TileSize = 4;

extern byte[] Ground;
extern byte[] VVramBack;
extern byte[] VVramFront;

extern bool VVramChanged;

extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void RollDown();
