constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVram;

// extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);
// extern void SetRowFlags(byte y, byte b);
extern void DrawBackGround();

// extern void Put2S(word offset, ptr<byte> pChars);
// extern void Put2C(byte x, byte y, byte c);
extern void DrawAll();
