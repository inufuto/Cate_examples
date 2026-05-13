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

ptr<byte> Put2C(ptr<byte> pVram, byte c, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c, right);
            right = !right;
            ++c;
        }
        pVram += VramRowSize - 2 / 2;
    }
    pVram += -VramRowSize * 2 + 2 / 2;
    return pVram;
}


ptr<byte> Erase2(ptr<byte> pVram, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, 0, right);
            right = !right;
        }
        pVram += VramRowSize - 2 / 2;
    }
    pVram += -VramRowSize * 2 + 2 / 2;
    return pVram;
}