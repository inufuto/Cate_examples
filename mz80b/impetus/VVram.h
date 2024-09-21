constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;
constexpr byte TileSize = 4;

extern byte[] Ground;
extern byte[] VVramBack;
extern byte[] VVramFront;

extern bool VVramChanged;
extern byte[] RowFlags;



extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void SetRowFlags(byte y, byte b);
extern void RollDown();
// extern void StatusToVVram();

extern void DrawAll();
