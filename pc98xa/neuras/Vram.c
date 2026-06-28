#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"

extern void _deb();

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
