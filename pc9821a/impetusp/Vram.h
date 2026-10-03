constexpr byte CharHeight = 8;
constexpr byte CharWidth = 8;

constexpr word VramOrg = 0x0000;
constexpr byte VramWidth = 80;
constexpr byte VramHeight = 28;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr word Vram = VramOrg + (30 - VramHeight) * VramRowSize / 2;
constexpr byte VramStep = 1;

extern void SwitchVram();
extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern void EraseBackup(byte x, byte y, byte count);
extern void DrawSprite2(byte x, byte y, byte pattern);
extern void DrawSprite1(byte x, byte y, byte pattern);
extern void DrawFort(byte x, byte y);

extern void DrawAll();
