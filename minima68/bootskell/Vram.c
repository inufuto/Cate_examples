#include "Vram.h"
#include "Chars.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
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
    return pVram + 2 - VramRowSize * 2;
}


ptr<byte> Put2CXY(byte x, byte y, byte c)
{
    return Put2C(VramPtr(x, y), c);
}


ptr<byte> Put2SXY(byte x, byte y, ptr<byte> pChars)
{
    return Put2S(VramPtr(x, y), pChars);
}
