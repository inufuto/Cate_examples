#include "Vram.h"
#include "Chars.h"

extern void _deb();

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
