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
    CallSound();
}

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        pVram = Put3(pVram, c);
        ++c;
    }
    pVram += VramRowSize3 - 2 * VramStep;
    repeat (2) {
        pVram = Put2(pVram, c);
        ++c;
    }
    return pVram - VramRowSize3;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        pVram = Put3(pVram, Char_Space);
    }
    pVram += VramRowSize3 - 2 * VramStep;
    repeat (2) {
        pVram = Put2(pVram, Char_Space);
    }
    return pVram - VramRowSize3;
}
