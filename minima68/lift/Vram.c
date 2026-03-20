#include "Vram.h"
#include "Chars.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(pVram, c);
            ++c;
            pVram += VramStep;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 *VramStep - VramRowSize * 2;
}


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramPtr(x, y), c);
}


void Erase2XY(byte x, byte y)
{
    ptr<byte> pVram;
    pVram = VramPtr(x, y);
    repeat (2) {
        repeat (2) {
            Put(pVram, Char_Space);
            pVram += VramStep;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
}
