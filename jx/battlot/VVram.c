#include "VVram.h"
#include "Chars.h"

byte [VVramWidth * VVramHeight] VVram;

// ptr<byte> VVramPtr(byte x, byte y)
// {
//     return VVram + ((word)y << 5) + x;
// }

void VPut2(ptr<byte> pVVram, byte c)
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

void VPut2XY(byte x, byte y, byte c)
{
    VPut2(VVramPtr(x, y), c);
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


void VErase2XY(byte x, byte y) 
{
    VErase2(VVramPtr(x, y));
}
