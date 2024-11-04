#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "VVram.h"
#include "Fort.h"

bool BackgroundChanged;

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
        GroundToVVram();
    }
    EraseForts();
    EraseSprites();
    VVramToVram();
    DrawForts();
    DrawSprites();
    SwapPage();
}