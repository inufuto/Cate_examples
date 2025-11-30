constexpr word Vram = 0x0000;
constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth*CharHeight;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite1(byte x, byte y, byte pattern);
extern void DrawSprite2(byte x, byte y, byte pattern);

extern void DrawAll();
