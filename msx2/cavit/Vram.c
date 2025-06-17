#include "Vram.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}

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

word Put2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pChars);
            ++pChars;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}

void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramAddress(x, y), c);
}
