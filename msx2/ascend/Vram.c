#include "Vram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
