#include "Vram.h"

extern void _deb();

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    *pVram = c - ' ';
    return pVram + 1;
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVram = c; ++pVram;
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
}
