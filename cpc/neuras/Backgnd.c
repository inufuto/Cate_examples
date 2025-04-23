#include "Backgnd.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"

static ptr<byte> BackgndPointer(byte x, byte y) {
    return Backgnd + ((word)y << 5) + x;
}


void VErase2(byte x, byte y)
{
    ptr<byte> pVVram;
    pVVram = BackgndPointer(x, y);
    pVVram[0] = Char_Wall;
    pVVram[1] = Char_Wall;
    pVVram[32] = Char_Wall;
    pVVram[32 + 1] = Char_Wall;
    SetRowFlag2(y);
}

void VPut2(byte x, byte y, byte pattern)
{
    ptr<byte> pVVram;
    byte c;
    pVVram = BackgndPointer(x, y);
    c = (pattern << 2) + Char_Sprite;

    pVVram[0] = c++;
    pVVram[1] = c++;
    pVVram[32] = c++;
    pVVram[32 + 1] = c++;
    SetRowFlag2(y);
}
