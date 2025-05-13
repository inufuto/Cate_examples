constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void DrawAll();
