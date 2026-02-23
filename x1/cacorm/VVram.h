constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramFront, VVramBack;

extern word VVramOffset(byte x, byte y);
extern void MapToVVram();
extern void ClearFront();

extern void DrawAll();
