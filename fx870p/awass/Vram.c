#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"

void DrawAll() 
{    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
    PresentVram();
    CallSound();
}

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        pVram = Put(pVram, c, 0);
        ++c;
    }
    pVram -= 2 * 3;
    repeat (2) {
        pVram = Put(pVram, c, 3);
        ++c;
    }
    return pVram;
}
