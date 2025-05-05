constexpr word Vram = 0x0000;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte PatternSize = 4 * CharHeight;

constexpr byte VramStep = 4;
constexpr word VramRowSize = 0x0800;

extern void ClearScreen();
extern word Put(word yx, byte c);
extern void VVramToVram();

extern word PrintC(word yx, byte c);
extern word Put2C(word yx, byte c);
extern word Erase2(word yx);
extern void DrawAll();
