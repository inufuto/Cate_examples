extern byte[] VVram;
extern byte[3] RowFlags;
extern bool GroundChanged;

extern void DrawAll();
extern void SetRowFlag(byte y);

extern word VVramOffset(byte x, byte y);
extern void GroundToVVram();
extern void StatusToVVram();
