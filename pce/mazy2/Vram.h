constexpr word Vram = 0x0000;

constexpr byte CharHeight = 8;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 25;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
