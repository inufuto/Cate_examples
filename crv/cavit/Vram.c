#include "Vram.h"


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

void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}


void Put2S(word vram, ptr<byte> pCodes)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pCodes);
            ++pCodes;
        }
        vram += VramWidth - 2;
    }
}


