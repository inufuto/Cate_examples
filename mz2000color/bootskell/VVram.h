constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack;
extern byte[] VVramFront;
extern byte[] RowFlags;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void SetRowFlags(byte y, byte b);

extern void Put2S(word offset, ptr<byte> pChars);
extern void Put2C(byte x, byte y, byte c);
extern void DrawAll();
