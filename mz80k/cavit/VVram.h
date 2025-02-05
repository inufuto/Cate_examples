constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVramBack, VVramFront;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);

extern void VPut2SXY(byte x, byte y, ptr<byte> pChars);
extern void DrawAll();
