constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();

extern void DrawAll();
