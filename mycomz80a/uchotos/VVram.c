#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"

extern void PollVsync();

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll()
{
    PollVsync();
    VVramBackToFront();
    PollVsync();
    DrawSprites();
    VVramToVram();
    PollVsync();
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