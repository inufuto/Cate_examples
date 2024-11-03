#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "VVram.h"

word Put2C(word yx, byte c)
{
    repeat (2) {
        repeat (2) {
            yx = Put(yx, c);
            ++c;
        }
        yx += VramRowSize - 2 * VramStep;
    }
    return yx +(- VramRowSize * 2 + 2 * VramStep);
}


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwapPage();
}