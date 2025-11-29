#include "VVram.h"

constexpr word VramOrg = 0x0000;
constexpr byte VramWidth = 128;
constexpr byte VramHeight = 32;
constexpr byte CharHeight = 16;
constexpr byte VramStep = 2;
constexpr byte VramRowSize = VramWidth*CharHeight;
constexpr byte VramLeft = (90 - 80) / 2;
constexpr byte VramTop = (VramHeight - VVramHeight) / 2;
constexpr word Vram = VramOrg + VramRowSize * VramTop + VramLeft;

extern void ClearScreen();
extern word Put(word vram, byte c);
extern word PrintC(word vram, byte c);
extern void VVramToVram();
extern void SwitchVram();
extern void EraseBackup(byte x, byte y);
extern void DrawSprite1(byte x, byte y, byte pattern);
extern void DrawSprite2(byte x, byte y, byte pattern);

extern void DrawAll();
