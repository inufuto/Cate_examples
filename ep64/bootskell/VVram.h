constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack, VVramFront;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);

extern void VPut2S(word offset, ptr<byte> pChars);
extern void VPut2CXY(byte x, byte y, byte c);
extern void DrawAll();
