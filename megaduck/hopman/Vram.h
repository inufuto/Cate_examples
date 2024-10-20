constexpr word Vram = 0x9800;
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte VramHeight = 18;

constexpr byte WindowWidth = 20;
constexpr byte StatusHeight = 2;

extern byte HScroll;
extern word CurrentPage, NextPage;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern void SwitchPage();
extern word WriteVram(word vram, byte c);
extern void MapToVram();
extern void UpdateScroll();

extern word PrintC(word vram, byte c);
extern void Put2C(word vram, byte c);
