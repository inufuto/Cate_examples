#include "VVram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

void VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
}


void VErase2(ptr<byte> pVVram)
{
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space; ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}


void VPut2CXY(byte x, byte y, byte c)
{
    VPut2C(VVramPtr(x, y), c);
}


void VErase2XY(byte x, byte y)
{
    VErase2(VVramPtr(x, y));
}
