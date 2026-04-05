constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] CellMap;
extern byte[] VVram;

extern void VVramBackToFront();
extern ptr<byte> VVramPtr(byte x, byte y);
extern void CellMapToVVram();

extern void DrawAll();
