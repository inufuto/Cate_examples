constexpr word Vram = 0x0000;
constexpr word VramStep = 0x0001;
constexpr word VramRowSize = 0x0100;

constexpr byte VramWidth = 24;
constexpr byte Char_Remain = 0x81;
constexpr byte Char_Fence = 0x82;

extern void ClearScreen();
extern word PrintC(word yx, byte c);
extern void VVramToVram();
