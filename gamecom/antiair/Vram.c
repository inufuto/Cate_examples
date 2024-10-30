#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "VVram.h"
#include "Ufo.h"

extern void _deb();

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


word Erase2(word yx)
{
    repeat (2) {
        repeat (2) {
            yx = Put(yx, Char_Space);
        }
        yx += VramRowSize - 2 * VramStep;
    }
    return yx +(- VramRowSize * 2 + 2 * VramStep);
}


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        UfoMoved = false;
        DrawBackground();
        DrawUfos();
    }
    else if (UfoMoved) {
        UfoMoved = false;
        DrawUfos();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwapPage();
}