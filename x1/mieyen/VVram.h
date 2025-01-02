constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void ClearVVram();
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
