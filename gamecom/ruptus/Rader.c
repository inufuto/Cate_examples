#include "Rader.h"
#include "Vram.h"
#include "VVram.h"

void DrawFortOnRader(byte x, byte y, byte c)
{
    x = ((x - 8) >> 4) + VVramWidth;
    y = ((y - 8) >> 4) + RaderTop;
    word yx = (((word)y) << 8) | x;
    Put(yx, c);
}
