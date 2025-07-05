#include "Fighter.h"
#include "Sprite.h"

void ShowFighter(ptr<Movable> pFighter, byte pattern) 
{
    byte offset;
    offset = (pFighter->clock >> CoordShift) & 0x03;
    if (offset == 0x03) {
        offset = 0x01;
    }
    ShowSprite(pFighter, pattern + offset);
}

