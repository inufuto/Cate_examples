#include "Vram.h"
#include "Chars.h"

byte HScroll;

extern void _deb();

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}


void Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            c += 2;
        }
        c -= 3;
        pVram += VramRowSize - 2 * VramStep;
    }
}


void Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
}


void Put2CXY(byte x, byte y, byte c)
{
    Put2C(VramPtr(x, y), c);
}


void Erase2XY(byte x, byte y)
{
    Erase2(VramPtr(x, y));
}