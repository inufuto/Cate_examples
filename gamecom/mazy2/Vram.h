constexpr word Vram = 0x0000;
constexpr word VramStep = 0x0001;
constexpr word VramRowSize = 0x0100;

constexpr byte StatusHeight = 2;
constexpr byte WindowWidth = 25;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern void VVramToVram();
extern void SwapPage();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern void DrawAll();
