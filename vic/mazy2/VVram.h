constexpr byte WindowWidth = 32;

constexpr byte VVramWidth = WindowWidth * 3 / 4;
constexpr byte VVramHeight = 24 - 2;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);

extern void DrawAll();
