#include "Vram.h"
#include "Chars.h"


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            ++c;
            ++vram;
        }
        vram += VramRowSize - 2;
    }
}

void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}


void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            Put(vram, Char_Space);
            ++vram;
        }
        vram += VramRowSize - 2;
    }
}


void Erase2XY(byte x, byte y) 
{
    Erase2(VramAddress(x, y));
}