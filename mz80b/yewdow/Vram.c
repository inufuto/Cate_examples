#include "Vram.h"
#include "Chars.h"
#include "VVram.h"
#include "Item.h"
#include "Sprite.h"
#include "Sound.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
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


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


void DrawAll()
{
    MapToVVram();
    DrawItems();
    DrawSprites();
    VVramToVram();
    CallSound();
}
