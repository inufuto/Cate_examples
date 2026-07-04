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


void VPut2C(byte x, byte y, byte c)
{
    ptr<byte> pVVram;
    pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}
