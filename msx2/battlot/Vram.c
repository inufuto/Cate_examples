#include "Vram.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}