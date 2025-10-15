#include "Vram.h"

constexpr byte VVramWidth = VramWidth;
constexpr byte VVramHeight = 22;

extern byte[] VVramBack;
extern byte[] VVramFront;

extern bool VVramChanged;
extern byte[] RowFlags;



extern void ClearVVram();
extern void VVramBackToFront();
extern word VVramOffset(byte x, byte y);
extern void SetRowFlags(byte y, byte b);
extern void GroundToVVram();

extern void DrawAll();
