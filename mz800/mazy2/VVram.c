#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
// #include "Sound.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll() {    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
    // CallSound();
}


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
