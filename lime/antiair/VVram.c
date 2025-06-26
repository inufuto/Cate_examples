#include "VVram.h"
#include "Chars.h"

byte [VVramWidth * VVramHeight] VVram;


void DrawGround()
{
    ptr<byte> pVVram = VVram + VVramWidth * (VVramHeight - 1);
    repeat (WindowWidth) {
        *pVVram = Char_Fence;
        ++pVVram;
    }
}