#include "Vram.h"

void Put2C(ptr<byte> pVram, byte c, byte pattern, byte color)
{
    repeat (2) {
        LocatePattern(pVram, 0, c);
        repeat (2) {
            PutPattern(pattern);
            ++pattern;
        }
        EndPrint();
        PutColor(pVram, color, 3);
        pVram += VramRowSize;
        c += 2;
    }
}
