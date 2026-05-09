constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern ptr<byte> VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
