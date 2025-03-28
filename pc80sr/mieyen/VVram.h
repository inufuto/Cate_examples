constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVramBack, VVramFront;

extern word VVramOffset(byte x, byte y);
extern void ClearVVramFront();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
