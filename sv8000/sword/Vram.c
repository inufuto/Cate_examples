#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

void DrawAll()
{
    EraseSprites();
    DrawSprites();
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


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Put2CXY(byte x, byte y, byte c)
{
    word vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Erase2XY(byte x, byte y)
{
    word vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}