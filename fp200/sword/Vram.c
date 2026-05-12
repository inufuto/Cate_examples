#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"

void DrawAll() 
{    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
}

word Put2C(word vram, byte c, bool right)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c, right);
            right = !right;
            ++c;
        }
        vram += VramRowSize - 2 / 2;
    }
    vram += -VramRowSize * 2 + 2 / 2;
    return vram;
}

word Erase2(word vram, bool right)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, 0, right);
            right = !right;
        }
        vram += VramRowSize - 2 / 2;
    }
    vram += -VramRowSize * 2 + 2 / 2;
    return vram;
}