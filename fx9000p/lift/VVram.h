constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16-2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawBackGround();

extern void DrawAll();
