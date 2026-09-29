constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VPut(ptr<byte> pVVram, byte c);

extern void DrawAll();
