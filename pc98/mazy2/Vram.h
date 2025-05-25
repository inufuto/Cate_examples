constexpr word Vram = 0x0000;

constexpr byte VramWidth = 80;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 40;
constexpr byte VramRowSize = VramWidth*CharHeight;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
