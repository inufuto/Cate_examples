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


void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}


void Put2SXY(byte x, byte y, ptr<byte> pChars)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            Put(vram, *pChars);
            ++pChars;
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void Erase2XY(byte x, byte y)
{
    Erase2(VramAddress(x, y));
}

