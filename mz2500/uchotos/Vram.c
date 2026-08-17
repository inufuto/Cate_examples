#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramPtr(x, y), c);
}

void Put2SXY(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVram = VramPtr(x, y);
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, *pChars);
            ++pChars;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
}