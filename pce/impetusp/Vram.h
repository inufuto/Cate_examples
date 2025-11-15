constexpr word Vram = 0x0000;

constexpr byte CharHeight = 8;
constexpr byte VramWidth = 32;
constexpr byte VramHeight = 26;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;

constexpr byte StatusHeight = 2;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern byte FromAscii(byte c);
extern word PrintC(word vram, byte c);
extern void StatusToVram();
extern void SwitchVram();
