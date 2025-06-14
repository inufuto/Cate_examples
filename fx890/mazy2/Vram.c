#include "Vram.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    ptr<byte> pRight;
    byte rightShift;
    repeat (2) {
        ptr<byte> pLeft = pVram;
        byte leftShift = CharShift;
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pRight = pVram;
        rightShift = CharShift;
        pVram = pLeft + VramWidth * 3;
        CharShift = leftShift;
    }
    CharShift = rightShift;
    return pRight - VramWidth * 3;
}
