#include "Vram.h"

word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 1;
}
