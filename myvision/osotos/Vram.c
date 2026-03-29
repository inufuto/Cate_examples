#include "Vram.h"
#include "Chars.h"

extern void _deb();

bool BackgroundChanged;

word PrintC(word vram, byte c)
{
    return Put(vram, c - 0x20);
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}


word Put2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, *pChars);
            ++pChars;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}
