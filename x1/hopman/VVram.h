constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24;

extern byte[] VVramBack, VVramFront;

extern void DrawAll();

extern void ClearVVramFront();
extern word VVramOffset(byte x, byte y);
extern void MapToVVram();
