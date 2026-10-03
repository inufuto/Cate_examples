#include "Vram.h"
#include "Chars.h"

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

void Put4C(word vram, ptr<byte> pBytes)
{
    repeat(4) {
        repeat(4) {
            Put(vram, *pBytes);
            ++pBytes;
            vram += VramStep;
        }
        vram += VramRowSize - 4 * VramStep;
    }
}