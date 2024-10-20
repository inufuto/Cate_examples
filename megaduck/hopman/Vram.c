#include "Vram.h"
#include "Chars.h"

byte HScroll;

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            c += 2;
        }
        c -= 3;
        vram += VramRowSize - 2 * VramStep;
    }
}
