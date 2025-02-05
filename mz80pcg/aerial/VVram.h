#include "Vram.h"

constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack;
extern byte[] VVramFront;
extern bool VVramChanged;

extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void GroundToVVram();

extern void DrawAll();
