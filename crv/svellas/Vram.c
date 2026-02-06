#include "Vram.h"
#include "Chars.h"

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
    Put2C(VramAddress(x, y), c);
}


word Erase2XY(byte x, byte y)
{
    Erase2(VramAddress(x, y));
}