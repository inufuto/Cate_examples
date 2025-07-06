constexpr word Vram = 0x0000;

constexpr byte VramWidth = 80;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * 16;

constexpr byte StageWidth = 32;
constexpr byte StageHeight = 25;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void DrawGround();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern void EraseBackupH(byte x, byte y, byte width);
extern void DrawBarrierLine(byte x, byte y, byte length);
extern void DrawFortPattern(byte x, byte y);

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
