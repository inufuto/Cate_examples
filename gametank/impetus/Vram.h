#include "VVram.h"

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight - 1;

constexpr word VramOrg = 0x4000;
constexpr byte CharWidth = 4;
constexpr byte CharHeight = 4;
constexpr byte AsciiHeight = 6;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 128;
constexpr byte VramVisibleHeight = CharHeight * WindowHeight;
constexpr byte VramTopY = (VramHeight - VramVisibleHeight) / 2;
constexpr word Vram = VramOrg;// + VramWidth * VramTopY;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte VramStep = CharWidth;

extern byte ScrollY;

extern void ClearScreen();
extern void PresentBackground();
extern void PresentForeground();
extern void EraseRightEnd();
extern void SwitchPage();
extern word PrintC(word vram, byte c);
extern word Put(word vram, byte c);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void VVramToVram();
extern void UpdateOffset();
extern void DrawBarrierLine(byte x, byte y, byte length);
extern void DrawFort();

extern void DrawAll();
