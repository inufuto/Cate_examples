constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 14;

extern byte[] VVram;

extern void DrawAll();

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();
