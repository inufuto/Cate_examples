constexpr byte VramWidth = 40;
constexpr byte VramHeight = 30;
constexpr word Vram = 0x0000;
constexpr byte VramStep = 0x0001;
constexpr byte VramRowSize = 0x0100;

extern bool BackgroundChanged;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();

extern void DrawAll();
