#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Point.h"

void DrawAll()
{
    EraseSprites();
    DrawSprites();
    DrawPoints();
    FlushVBuffer();
}

word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Put2CQ(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}

word Erase2Q(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}
