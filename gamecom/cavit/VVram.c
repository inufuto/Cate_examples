#include "VVram.h"
#include "Chars.h"

ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
     repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram +(- VVramWidth * 2 + 2);
}


ptr<byte> VPut2S(ptr<byte> pVVram, ptr<byte> pChars)
{
     repeat (2) {
        repeat (2) {
            *pVVram = *pChars; ++pVVram;
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram +(- VVramWidth * 2 + 2);
}


ptr<byte> VErase2(ptr<byte> pVVram)
{
     repeat (2) {
        repeat (2) {
            *pVVram = Char_Space; ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram +(- VVramWidth * 2 + 2);
}