constexpr ptr<byte> VVram = (ptr<byte>)0xe000;
constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 20 - 2;

extern bool VVramChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawGround();
extern void RollDown();
