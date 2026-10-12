constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
extern ptr<byte> VPut2CXY(byte x, byte y, byte c);
extern ptr<byte> VErase2XY(byte x, byte y);