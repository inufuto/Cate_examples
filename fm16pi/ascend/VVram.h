constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void BackgroundToVVram();

extern void VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
extern void VPut2C(byte x, byte y, byte c);
extern void VErase2(byte x, byte y);