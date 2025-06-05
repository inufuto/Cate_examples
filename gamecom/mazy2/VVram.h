constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 25;
constexpr byte VVramHeight = 16;

extern ptr<byte> VPut(ptr<byte> pVVram, byte c);
