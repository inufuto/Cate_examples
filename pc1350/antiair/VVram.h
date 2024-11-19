constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

extern byte[] VVramBack, VVramFront;
extern bool BackgroundChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern void DrawBackground();

extern void DrawAll();
