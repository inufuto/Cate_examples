constexpr byte VVramWidth = WindowWidth;
constexpr byte VVramHeight = WindowHeight;

extern byte[] VVram;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVram, byte c);
