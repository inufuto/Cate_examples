constexpr byte VVramWidth = 32 - 6;
constexpr byte VVramHeight = 27;

extern byte[] VVram;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);
