#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}

ptr<byte> VErase2(ptr<byte> pVVram)
{
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space; ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}

ptr<byte> VPut2CXY(byte x, byte y, byte c)
{
    return VPut2C(VVramPtr(x, y), c);
}

ptr<byte> VErase2XY(byte x, byte y)
{
    return VErase2(VVramPtr(x, y));
}
