#include "Vram.h"

extern void _deb();

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        pVram = Put3(pVram, c);
        ++c;
    }
    pVram += VramRowSize3 - 2 * VramStep;
    repeat (2) {
        pVram = Put2(pVram, c);
        ++c;
    }
    return pVram - VramRowSize3;
}
