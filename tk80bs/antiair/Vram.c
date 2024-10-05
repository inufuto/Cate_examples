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


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            *pVram = ' '; ++pVram;
        }
        pVram += VramRowSize - 2;
    }
    return pVram + 2 - VramRowSize * 2;
}