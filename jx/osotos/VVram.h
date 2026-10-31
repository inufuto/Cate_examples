constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
extern ptr<byte> VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
