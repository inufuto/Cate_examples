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
