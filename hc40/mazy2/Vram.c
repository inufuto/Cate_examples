#include "Vram.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c, right);
            right = !right;
            ++c;
        }
        pVram += VramRowSize - 2 / 2;
    }
    pVram += -VramRowSize * 2 + 2 / 2;
    return pVram;
}
