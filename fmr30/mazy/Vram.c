#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
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
