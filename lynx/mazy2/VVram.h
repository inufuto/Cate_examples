constexpr byte VVramWidth = 25;
constexpr byte VVramHeight = 16;

extern byte[] VVram;

extern ptr<byte> VPut(ptr<byte> pVVram, byte c);
