constexpr byte VVramWidth = 8;
constexpr byte VVramHeight = 4;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void DrawAll();
