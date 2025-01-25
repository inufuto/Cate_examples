constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern byte[] VVram;

extern ptr<byte> VPut(ptr<byte> pVVram, byte c);
extern void ClearVVram();
