constexpr word Vram = 0xc000 * 2;

constexpr byte VramWidth = 32;
constexpr byte CharHeight = 4;
constexpr byte AsciiHeight = 6;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte VramHeight = 24;

constexpr byte StageTop = 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void FlushVBuffer();
extern word VAdd(word vram, byte c);
extern word VAddOver(word vram, byte c);
extern word VramAddress(byte x, byte y);

extern void DrawAll();
extern word Put2C(word vram, byte c);
extern word Put2CQ(word vram, byte c);
extern word Erase2Q(word vram);