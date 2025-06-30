#include "Vram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
