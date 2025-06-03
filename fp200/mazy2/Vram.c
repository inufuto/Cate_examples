#include "Vram.h"

word Put2C(word vram, byte c, bool right)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c, right);
            right = !right;
            ++c;
        }
        vram += VramRowSize - 2 / 2;
    }
    vram += -VramRowSize * 2 + 2 / 2;
    return vram;
}
