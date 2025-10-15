#include "Fighter.h"
#include "Sprite.h"

void ShowFighter(ptr<Movable> pFighter, byte pattern)
{
    // byte offset;
    // offset = (pFighter->clock >> (CoordShift - 2)) & 0x0c;
    // if (offset == 0x0c) {
    //     offset = 0x04;
    // }
    ShowSprite(pFighter, pattern /*+ offset*/);
}

