#include "Vram.h"
#include "Sprite.h"

word Put2S(word yx, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            yx = Put(yx, *pChars);
            ++pChars;
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