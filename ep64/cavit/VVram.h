constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack, VVramFront;
extern bool VVramChanged;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);

extern void Put4C(byte x, byte y, byte c);
extern void DrawAll();
