constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24;

extern byte[] VVram;
extern bool VVramChanged;

extern void ClearVVram();
extern ptr<byte> VVramPtr(byte x, byte y);

extern void Put1(sbyte x, sbyte y, byte c);
extern void Put6(sbyte x, sbyte y, byte c);
