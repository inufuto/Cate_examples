constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 14;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern ptr<byte> VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
