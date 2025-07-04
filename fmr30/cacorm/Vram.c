#include "Vram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Sound.h"

void DrawAll()
{
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
    // CallSound();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
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
