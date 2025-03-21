#include "Vram.h"
#include "Chars.h"

extern void _deb();

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - 0x20);
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}


ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, *pChars);
            ++pChars;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
