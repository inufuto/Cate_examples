#include "Vram.h"
#include "Chars.h"

void Put2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pChars);
            ++pChars;
        }
        vram += VramWidth - 2;
    }
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramWidth - 2;
    }
}


void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramWidth - 2;
    }
}
