constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack, VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();

extern void DrawAll();
extern void VPut2(ptr<byte> pVVram, byte c);
extern void VPut2XY(byte x, byte y, byte c);
extern void VErase2(ptr<byte> pVVram);
extern void VErase2XY(byte x, byte y);
extern void MapToVVram();
