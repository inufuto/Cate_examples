constexpr word Vram = 0x9800;
constexpr byte VramWidth = 32;
constexpr byte VramStep = 1;
constexpr byte VramRowSize = VramWidth * VramStep;
constexpr byte VramHeight = 18;

constexpr byte WindowWidth = 20 - 6;
constexpr byte WindowHeight = 18;

extern word CurrentPage, NextPage;
extern bool BackgroundChanged;

extern void ClearScreen();
extern word VramOffset(byte x, byte y);
extern word Put(word vram, byte c);
extern void SwitchPage();

extern word WriteVram(word vram, byte c);
extern void ClearBackground();

extern word PrintC(word vram, byte c);
extern word Put2C(word vram, byte c);
extern word Erase2(word vram);
extern void DrawAll();
extern void BPut(byte x, byte y, byte c);
extern void BPut6(byte x, byte y, byte c);
