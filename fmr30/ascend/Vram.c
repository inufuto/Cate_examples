#include "Vram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "CopyMemory.h"
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
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
