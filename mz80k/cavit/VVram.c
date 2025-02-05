#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void VPut2SXY(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = *pChars;
            ++pChars;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
}


void DrawAll() {    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
}
