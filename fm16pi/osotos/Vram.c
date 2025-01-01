#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

extern void _deb();

void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
}

word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
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