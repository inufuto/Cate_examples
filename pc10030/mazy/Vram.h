constexpr word VramOrg = 0x0000;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 32;
constexpr byte CharHeight = 16;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth*CharHeight;
constexpr byte VramLeft = (VramWidth - 80) / 2;
constexpr byte VramTop = (VramHeight - 25) / 2;
constexpr word Vram = VramOrg + VramWidth * 56 + 5;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();

extern void DrawAll();
extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
