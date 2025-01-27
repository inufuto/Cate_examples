#include "Vram.h"

extern void _deb();

ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            *pVram = *pChars; ++pVram;
            ++pChars;
        }
        pVram += VramRowSize - 2;
    }
    return pVram + 2 - VramRowSize * 2;
}
