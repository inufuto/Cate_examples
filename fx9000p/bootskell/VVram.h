#include "Vram.h"

constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern byte[] VVramBack;
extern byte[] VVramFront;

extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);

extern void VPut2S(word offset, ptr<byte> pChars);
extern void VPut2C(byte x, byte y, byte c);
extern void DrawAll();
