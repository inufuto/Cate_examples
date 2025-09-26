#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

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


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}


void Erase2XY(byte x, byte y)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}

void DrawAll()
{
    EraseSprites();
    DrawSprites();
    SwitchGVram();
    // CallSound();
}
