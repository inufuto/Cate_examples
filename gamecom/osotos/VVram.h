constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 17 - 2;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void VPut2C(ptr<byte> pVVram, byte c);
extern void VPut2S(ptr<byte> pVVram, ptr<byte> pChars);
extern void VErase2(ptr<byte> pVVram);
