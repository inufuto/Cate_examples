#include "Vram.h"
#include "vVram.h"
#include "Sprite.h"
// #include "Sound.h"

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramToVram();
    }
    PresentBackground();
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
    // CallSound();
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
