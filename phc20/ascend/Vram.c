#include "Vram.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    pVram = Put3L(pVram, c); ++c;
    pVram = Put3R(pVram, c); ++c;
    pVram += VramRowSize3 - 1;
    pVram = Put3L(pVram, c); ++c;
    pVram = Put3R(pVram, c); ++c;
    return pVram - VramRowSize3;
}
