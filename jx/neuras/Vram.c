#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
}


void Put2C(word vram, byte c)
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

void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
