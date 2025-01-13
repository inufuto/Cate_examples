#include "Vram.h"
#include "Chars.h"

extern void _deb();

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
