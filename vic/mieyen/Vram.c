#include "Vram.h"
#include "Chars.h"

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


void Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            *pVram = Char_Space;
            ++pVram;
        }
        pVram += VramRowSize - 2;
    }
}
