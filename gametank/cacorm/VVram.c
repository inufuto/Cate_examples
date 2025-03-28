#include "VVram.h"
#include "Chars.h"

byte [VVramWidth * VVramHeight] VVram;

void VPut2S(ptr<byte> pVVram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            *pVVram = *pChars;
            ++pChars;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}


void VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}


void VErase2(ptr<byte> pVVram)
{
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}
