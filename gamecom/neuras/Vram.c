#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"

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
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwapPage();
}