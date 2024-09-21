#include "Vram.h"

void InitVram()
{
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 1;
}
