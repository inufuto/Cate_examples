#include "Vram.h"
#include "Chars.h"

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
