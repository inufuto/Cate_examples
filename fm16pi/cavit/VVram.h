constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut4C(byte x, byte y, byte c);