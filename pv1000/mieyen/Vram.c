#include "Vram.h"
#include "Chars.h"

extern void _deb();

byte XOffset;

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
