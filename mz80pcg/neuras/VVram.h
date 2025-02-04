constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack, VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern void DrawAll();
extern void VErase2(byte x, byte y);
extern void VPut2C(byte x, byte y, byte c);
extern void VPut2S(byte x, byte y, ptr<byte> pChars);
extern void MapToVVram();
