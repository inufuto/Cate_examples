constexpr word Vram = 0;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 32;
constexpr byte VramRowSize = VramWidth;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void VVramToVram();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);

extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern word Put2C(word vram, byte c);
extern void DrawAll();
