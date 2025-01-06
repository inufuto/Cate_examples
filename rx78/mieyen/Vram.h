constexpr word Vram = 0xeec0;
constexpr byte VramWidth = 24;
constexpr byte VramHeight = 23;
constexpr byte CharHeight = 8;
constexpr byte VramRowSize = VramWidth * CharHeight;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern void Put(word vram, byte c);
extern void PutShift(word vram, byte xMod, byte c);
extern void VVramToVram();
extern void Locate(word vram, bool shift);
extern void PrintC(byte c);
