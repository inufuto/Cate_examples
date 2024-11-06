constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void ClearVVram();

extern ptr<byte> VPut2C(ptr<byte> pVram, byte c);
extern ptr<byte> VPut2S(ptr<byte> pVram, ptr<byte> pChars);
extern ptr<byte> VErase2(ptr<byte> pVram);
