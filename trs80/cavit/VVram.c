#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;


void VPut2C(byte x, byte y, byte c)
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
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    CallSound();
}
