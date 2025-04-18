#include "VVram.h"

constexpr word VramOrg = 0x4000;
constexpr byte CharWidth = 4;
constexpr byte CharHeight = 4;
constexpr byte AsciiHeight = 6;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 128;
constexpr byte VramVisibleHeight = CharHeight * VVramHeight;
constexpr byte VramTopY = (VramHeight - VramVisibleHeight) / 2;
constexpr word Vram = VramOrg + VramWidth * VramTopY;
constexpr byte VramRowSize = VramWidth * CharHeight;
constexpr byte VramStep = CharWidth;

extern bool BackgroundChanged;

extern void ClearScreen();
extern void PresentBackground();
extern void EraseRightEnd();
extern void SwitchPage();
extern word PrintC(word vram, byte c);
extern word Put(word vram, byte c);
extern void DrawSprite(byte x, byte y, byte pattern);
extern void VVramToVram();
extern word VramAddress(byte x, byte y);

extern void DrawAll();
extern void Put2C(word vram, byte c);
extern void Erase2(word vram);
extern void Put4S(word vram, ptr<byte> pBytes);