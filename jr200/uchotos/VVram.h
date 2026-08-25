constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 23;
constexpr byte WindowHeight = VVramHeight;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
extern void VPut2CXY(byte x, byte y, byte c);
extern void VPut2SXY(byte x, byte y, ptr<byte> pChars);
