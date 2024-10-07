#include "VVram.h"
#include "Vram.h"

byte[WindowWidth * WindowHeight] VVram;

ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += WindowWidth - 2;
    }
    return pVVram + 2 - WindowWidth * 2;
}