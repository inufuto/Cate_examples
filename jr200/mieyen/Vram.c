#include "Vram.h"
#include "Chars.h"

extern void _deb();

ptr<byte> Put2C(ptr<byte> pVram, byte c, byte color)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c, color);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
