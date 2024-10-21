#include "Vram.h"
#include "Chars.h"

extern void _deb();

byte HScroll;

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
