#include "Vram.h"

extern void _deb();

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        pVram = PutU(pVram, c);
        ++c;
    }
    pVram -= 2 * CharWidth;
    repeat (2) {
        pVram = PutL(pVram, c);
        ++c;
    }
    return pVram;
}
