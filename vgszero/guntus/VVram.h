extern byte[] VVram;

constexpr byte VVramWidth = 30;
constexpr byte VVramHeight = 24;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);
