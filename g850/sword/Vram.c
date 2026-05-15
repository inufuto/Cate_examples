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
    pVram -= 2 * CharWidth;
    repeat (2) {
        pVram = Put(pVram, c, 3);
        ++c;
    }
    return pVram;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        pVram = Put(pVram, Char_Space, 0);
    }
    pVram -= 2 * CharWidth;
    repeat (2) {
        pVram = Put(pVram, Char_Space, 3);
    }
    return pVram;
}