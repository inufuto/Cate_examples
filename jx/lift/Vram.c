#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"
// #include "Sound.h"

void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    // CallSound();
}


void Put2(word vram, byte c)
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
