#include "Vram.h"

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


void Put2C(byte x, byte y, byte c)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramWidth - 2;
    }
}
