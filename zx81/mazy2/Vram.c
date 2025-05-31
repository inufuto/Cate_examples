#include "Vram.h"
#include "Sprite.h"
#include "Point.h"

ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, *pChars);
            ++pChars;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
}


void DrawAll() 
{
    DrawBackground();
    DrawSprites();
    DrawPoints();
    SwitchPage();
    // CallSound();
}
