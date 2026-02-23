constexpr byte VVramStep = 2;
constexpr byte TVVramWidth = WindowWidth * 2;
constexpr byte GVVramWidth = WindowWidth * 4;
constexpr byte VVramHeight = WindowHeight;

extern byte[] TVVram, GVVram;
extern bool AllChanged;

extern void ClearTVVram();
extern void ClearGVVram();
extern word VVramOffset(byte x, byte y);
extern void SetRowFlags(byte y, byte b);

extern void DrawAll();
extern ptr<byte> VPut2C(ptr<byte> pVVram, byte c);
