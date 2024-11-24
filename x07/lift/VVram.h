constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawBackGround();
extern ptr<byte> VPrintC(ptr<byte> pVVram, byte c);

extern ptr<byte> VPrintS(ptr<byte> pVVram, ptr<byte> p);
extern void DrawAll();
