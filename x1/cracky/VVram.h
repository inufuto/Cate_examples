constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void ClearVVram();
extern void SetRowFlags(byte y, byte b);

extern void DrawAll();
