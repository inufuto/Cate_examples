constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
extern void VPut2C(byte x, byte y, byte c);
