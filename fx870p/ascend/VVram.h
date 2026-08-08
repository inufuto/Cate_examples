#include "Vram.h"

constexpr byte VVramWidth = 24;
constexpr byte VVramHeight = 16;

constexpr byte WindowWidth = VVramWidth;
constexpr byte WindowHeight = VVramHeight;

extern byte[] VVram;

extern ptr<byte> VVramPtr(byte x, byte y);
extern void MapToBackGround();

extern void DrawAll();
