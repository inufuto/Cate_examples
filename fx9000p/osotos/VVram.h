constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 1;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawBackground();

extern void DrawAll();
