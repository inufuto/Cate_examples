#include "Vram.h"

void Put2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            WriteVram(vram, *pChars);
            ++pChars;
            ++vram;
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
            WriteVram(vram, c);
            ++c;
            ++vram;
        }
        vram += VramWidth - 2;
    }
}
