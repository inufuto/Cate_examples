#include "Vram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
