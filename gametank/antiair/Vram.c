#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Ufo.h"
#include "Block.h"
#include "Sprite.h"

extern void _deb();

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawBackground();
        DrawUfos();
    }
    else if (UfoMoved) {
        UfoMoved = false;
        DrawUfos();
    }
    VVramToVram();
    PresentBackground();
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}
