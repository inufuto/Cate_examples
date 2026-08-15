#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll()
{
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
}

void VPut2CXY(byte x, byte y, byte c)
{
    ptr<byte> pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, c);
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
}

void VPut2SXY(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, *pChars);
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
}