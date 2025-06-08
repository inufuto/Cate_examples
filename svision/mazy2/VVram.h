constexpr byte VVramWidth = 19;
constexpr byte VVramHeight = 16;

extern byte[] VVram;

extern ptr<byte> VPut(ptr<byte> pVVram, byte c);
