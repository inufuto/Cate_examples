constexpr byte VramWidth = 24;
constexpr word VramRowSize = VramWidth * 8;

extern byte[] Vram;

constexpr byte TopMargin = 1;

extern void PresentVram();
extern void ClearScreen();
extern ptr<byte> PrintC(ptr<byte> pVram, byte c, byte shift);
extern ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
extern void VVramToVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);
extern ptr<byte> VramPtr(byte x, byte y);
extern ptr<byte> BackupPtr(byte x, byte y);
