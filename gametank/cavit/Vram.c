#include "Vram.h"
#include "Sprite.h"

void DrawAll()
{
    VVramToVram();
    PresentBackground();
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
}


void Put2(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            ++c;
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
