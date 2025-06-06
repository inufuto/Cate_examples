#include "Vram.h"

byte XOffset;

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
