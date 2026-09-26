constexpr byte CharHeight = 8;
constexpr byte CharWidth = 8;

constexpr word VramOrg = 0x0000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 24;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr word Vram = VramOrg + (30 - VramHeight) * VramRowSize / 2;
constexpr byte VramStep = 1;

extern void SwitchVram();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
