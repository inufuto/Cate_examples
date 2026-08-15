#include "Vram.h"
#include "Chars.h"

byte CharOffset;

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


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}


void Put2SXY(byte x, byte y, ptr<byte> pChars)
{
    word vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pChars);
            ++pChars;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}