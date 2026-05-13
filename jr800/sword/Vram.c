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
        pVram = PutU(pVram, c);
        ++c;
    }
    pVram -= 2 * VramStep;
    repeat (2) {
        pVram = PutL(pVram, c);
        ++c;
    }
    return pVram;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        pVram = PutU(pVram, Char_Space);
    }
    pVram -= 2 * VramStep;
    repeat (2) {
        pVram = PutL(pVram, Char_Space);
    }
    return pVram;
}