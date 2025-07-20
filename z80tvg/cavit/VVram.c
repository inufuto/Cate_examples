#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
bool VVramChanged;


void Put4C(byte x, byte y, byte c)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    VVramChanged = true;
}


void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
        DrawSprites();
    }
    else {
        EraseSprites();
        DrawSprites();
    }
    VVramToVram();
    PresentVram();
    CallSound();
}
