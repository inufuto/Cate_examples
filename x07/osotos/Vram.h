constexpr word Vram = 0x0000;
constexpr word VramStep = 0x0001;
constexpr word VramRowSize = 0x0100;

constexpr byte VramWidth = 24;
constexpr byte TopMargin = 1;
constexpr byte Char_Remain = 0x81;


extern void ClearScreen();
extern word PrintC(word yx, byte c);
extern void VVramToVram();

extern void DrawAll();
extern void DrawFence();
