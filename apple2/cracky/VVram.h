constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 24;

extern byte[] VVramBack, VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void ClearVVramBack();
extern void VVramBackToFront();
extern void SetRowFlags(byte y, byte b);
extern void ClearRowFlags();

extern void DrawAll();
