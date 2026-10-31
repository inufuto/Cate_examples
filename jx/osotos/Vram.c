#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
// #include "Sound.h"

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


void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    // CallSound();
}
