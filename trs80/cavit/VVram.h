#include "Vram.h"

constexpr byte VVramWidth = 20;
constexpr byte VVramHeight = 16 - 2;

extern byte[VVramWidth * VVramHeight] VVramBack;
extern byte[VVramWidth * VVramHeight] VVramFront;
extern bool VVramChanged;

extern word VVramOffset(byte x, byte y);
extern void VVramBackToFront();
extern void ClearVVram();
extern ptr<byte> TerrainMapPtr(byte x, byte y);

extern void VPut2C(byte x, byte y, byte c);
extern void DrawAll();
