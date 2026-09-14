constexpr word Vram = 0x0000;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 32;
constexpr byte CharHeight = 16;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth*CharHeight;
constexpr word VramOrg = Vram + VramWidth * 56 + 5;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void SwapVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite(byte x, byte y, byte pattern);

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);