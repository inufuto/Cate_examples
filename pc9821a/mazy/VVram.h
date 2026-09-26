#include "Vram.h"

constexpr byte VVramWidth = 32;
constexpr byte VVramHeight = VramHeight;
constexpr word VVramSize = VVramWidth * VVramHeight;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToVVram();

extern void VPut1(sbyte x, sbyte y, byte c);
extern void VPut2(sbyte x, sbyte y, byte c);
