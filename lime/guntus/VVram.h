constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

extern byte[] VVram;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);

extern ptr<byte> VPut2C(ptr<byte> pVram, byte c);
