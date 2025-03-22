#include "Fighter.h"
#include "Sprite.h"

void ShowFighter(ptr<Movable> pFighter, byte pattern)
{
    byte offset;
    offset = (pFighter->clock >> CoordShift) & 3;
    if (offset == 3) {
        offset = 1;
    }
    ShowSprite(pFighter, pattern + offset);
}
