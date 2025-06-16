#include "Vram.h"
#include "Chars.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}

void Put2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pChars);
            ++pChars;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void Put2C(byte x, byte y, byte c)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}


void Erase2(byte x, byte y)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
