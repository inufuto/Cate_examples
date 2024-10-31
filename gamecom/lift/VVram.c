#include "VVram.h"
#include "Chars.h"

void VPut2CXY(byte x, byte y, byte c)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
}


void VErase2XY(byte x, byte y)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space; ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}