#include "Vram.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        pVram = Put(pVram, c, 0);
        ++c;
    }
    pVram -= 2 * CharWidth;
    repeat (2) {
        pVram = Put(pVram, c, 3);
        ++c;
    }
    return pVram;
}
