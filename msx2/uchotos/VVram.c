#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

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

void VPut2SXY(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = *pChars; ++pVVram;
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
}
