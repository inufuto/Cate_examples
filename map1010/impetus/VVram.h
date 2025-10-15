constexpr byte TileSize = 4;
constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void RollDown();
extern void DrawGround();

extern void DrawAll();
