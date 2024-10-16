#include "Vram.h"

byte HScroll;

extern void _deb();

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}


void Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            c += 2;
        }
        c -= 3;
        pVram += VramRowSize - 2 * VramStep;
    }
}
