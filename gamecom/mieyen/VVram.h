constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 17 - 2;

extern ptr<byte> VVramPtr(byte x, byte y);
extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
extern ptr<byte> VErase2(ptr<byte> pVVram);
