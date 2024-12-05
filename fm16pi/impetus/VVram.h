constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 25;

extern bool BackgroundChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawGround();
extern void RollDown();
