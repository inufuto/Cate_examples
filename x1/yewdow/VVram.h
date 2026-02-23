constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVramBack, VVramFront;

extern void ClearVVramFront();
extern word VVramOffset(byte x, byte y);
extern void MapToVVram();
