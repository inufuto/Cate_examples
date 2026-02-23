constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;
constexpr byte TileSize = 4;

extern byte[] Ground;
extern byte[] VVramBack;
extern byte[] VVramFront;
extern byte[] TRowFlags;
extern word[] GVVram;
extern byte[] GRowFlags;

extern bool VVramChanged;

extern void DrawAll();

extern void ClearGVVram();
extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern void SetTRowFlags(byte y, byte b);
extern void SetGRowFlags(byte y, byte b);
extern void RollDown();
