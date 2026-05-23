constexpr word Vram = 0x8000;

constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = CharHeight;
constexpr byte VramRowSize = VramWidth * VramStep;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
