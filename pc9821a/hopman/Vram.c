#include "Vram.h"

word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            ++c;
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram - VramRowSize * 2 + 2 * VramStep;
}
