constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[VVramWidth * VVramHeight] VVram;
extern byte[3] RowFlags;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);

extern void DrawAll();
extern void SetRowFlags(byte y);
