constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 14;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
