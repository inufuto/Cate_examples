#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


void DrawAll()
{
    EraseSprites();
    DrawSprites();
    SwitchGVram();
    // CallSound();
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
