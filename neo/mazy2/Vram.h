constexpr byte VramWidth = 40;
constexpr byte VramHeight = 25;
constexpr word Vram = 0x0000;
constexpr byte VramStep = 0x0001;
constexpr byte VramRowSize = 0x0100;

constexpr byte StageTop = 1;

extern void ClearScreen();
extern word Put(word vram, byte c);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
