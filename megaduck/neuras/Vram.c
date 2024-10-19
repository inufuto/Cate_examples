#include "Vram.h"
#include "Chars.h"

byte VScroll, HScroll;
byte ScrollTerget;

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


void SetScrollTarget(byte x)
{
    static const byte[] ScrollPositions = {
        0,1,2,2,3,4,5,5,6,7,8,8,9,10,11,11,12,13,14,14,15,16,17,18,18,19,20,21,21,22,23,24,24,25,26,27,27,28,29,30,30,31,32
    };
    ScrollTerget = ScrollPositions[x >> 2];
}


void UpdateScroll()
{
    if (ScrollTerget < HScroll) {
        --HScroll;
    }
    else if (ScrollTerget > HScroll) {
        ++HScroll;
    }
}
