#include "Vram.h"

ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (2) {
        pVram = Put(pVram, *pChars, 0);
        ++pChars;
    }
    pVram -= 2 * 2;
    repeat (2) {
        pVram = Put(pVram, *pChars, 2);
        ++pChars;
    }
    return pVram;
}
