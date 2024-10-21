#include "Vram.h"
#include "Chars.h"

extern void _deb();

word PrintC(word vram, byte c)
{
    return Put(vram, c - 0x20);
}
