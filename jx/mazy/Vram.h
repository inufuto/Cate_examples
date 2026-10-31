constexpr word Vram = 0x0000;
constexpr byte VramWidth = 160;
constexpr byte VramHeight = 25;
constexpr byte VramRowSize = VramWidth * 2;
constexpr byte VramStep = VramWidth / 40;
constexpr byte CharHeight = 8;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();

extern word Put2C(word vram, byte c);
