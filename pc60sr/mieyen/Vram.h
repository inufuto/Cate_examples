constexpr word Vram = 0x1a00;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 25;
constexpr byte CharHeight = 8;
constexpr byte VramStep = VramWidth / 32;
constexpr byte VramRowSize = 0x400;
constexpr byte PatternSize = VramStep * CharHeight;

constexpr byte XStep = 4;
constexpr word YStep = 0x0800;

extern void ClearScreen();
extern word Put(word yx, byte c);
extern void VVramToVram();

extern word PrintC(word yx, byte c);
extern word Put2C(word yx, byte c);
extern word Erase2(word yx);
extern void DrawAll();
