#include "Vram.h"
#include "Chars.h"
#include "Stage.h"

extern void _deb();

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
            pVram = Put(pVram, Char_Space, right);
            right = !right;
        }
        pVram += VramRowSize - 1;
    }
    return pVram - VramRowSize * 2 + 1;
}


void Put2SXY(byte x, byte y, ptr<byte> pChars, bool right)
{
    Put2S(Vram + VramOffset(x, y + StageTop), pChars, right);
}


void Erase2XY(byte x, byte y, bool right)
{
    Erase2(Vram + VramOffset(x, y + StageTop), right);
}
