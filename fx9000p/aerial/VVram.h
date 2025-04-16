#include "Vram.h"

constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16 - 2;

extern byte[] VVramBack;
extern byte[] VVramFront;
extern bool VVramChanged;

extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void GroundToVVram();

extern void DrawAll();
