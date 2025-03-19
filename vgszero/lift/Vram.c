#include "Vram.h"
#include "Chars.h"

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}


void Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
}

void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramBack + VramOffset(x, y), c);
}


void Erase2XY(byte x, byte y)
{
    ptr<byte> pVram = VramBack + VramOffset(x, y);
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
}
