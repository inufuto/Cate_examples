#include "Vram.h"

ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, *pChars, right);
            right = !right;
            ++pChars;
        }
        pVram += VramRowSize - 1;
    }
    return pVram - VramRowSize * 2 + 1;
}

ptr<byte> Erase2(ptr<byte> pVram, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, 0, right);
            right = !right;
        }
        pVram += VramRowSize - 1;
    }
    return pVram - VramRowSize * 2 + 1;
}

void Put2SXY(byte x, byte y, ptr<byte> pChars)
{
    Put2S(VramPtr(x, y), pChars, false);
}