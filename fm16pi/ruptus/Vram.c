#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"


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

void Put4S(word vram, ptr<byte> pBytes)
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