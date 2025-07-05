constexpr word Vram = 0x0000;

constexpr byte VramWidth = 80;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth * 16;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void BackgroundToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern void EraseBackupH(byte x, byte y, byte width);
extern void MakeFortPattern();
extern void DrawFort(byte x, byte y, byte width);

extern word PrintC(word vram, byte c);
extern void DrawAll();
