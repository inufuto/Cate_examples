constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24 - 2;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawBackground();

extern void DrawAll();
