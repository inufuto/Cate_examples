#include "Vram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - 0x20);
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            c += 2;
        }
        vram += VramRowSize - 2 * VramStep;
        c += 1 - 4;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
