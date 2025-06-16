constexpr word Vram = 0x0000;

constexpr byte VramWidth = 32;
constexpr byte VramHeight = 24;
constexpr byte VramStep = 0x0008;
constexpr byte VramRowSize = 0x0800;

extern void InitVram();
extern void ClearScreen();
extern word VramAddress(byte x, byte y);
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);

extern void Put2S(word vram, ptr<byte> pChars);
extern void Put2C(byte x, byte y, byte c);
extern void Erase2(byte x, byte y);
