constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight;

extern byte[] VVram;
extern bool BackgroundChanged;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void DrawBackground();

extern void DrawAll();
