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


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y + StageTop), c);
}

void Erase2XY(byte x, byte y)
{
    Erase2(VramAddress(x, y + StageTop));
}


void Erase2XYQ(byte x, byte y)
{
    word vram = VramAddress(x, y + StageTop);
    repeat (2) {
        repeat (2) {
            vram = VAdd(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
}


void Put2CXYOver(byte x, byte y, byte c)
{
    word vram = VramAddress(x, y + StageTop);
    repeat (2) {
        repeat (2) {
            vram = VAddOver(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
}