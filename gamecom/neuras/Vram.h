constexpr word Vram = 0x0000;
constexpr word VramStep = 0x0001;
constexpr word VramRowSize = 0x0100;

constexpr byte VramWidth = 24;

extern void ClearScreen();
extern word Put(word yx, byte c);
extern word PrintC(word yx, byte c);
extern void VVramToVram();
extern void SwapPage();

extern word Put2C(word yx, byte c);
extern word Erase2(word yx);
extern void DrawAll();
