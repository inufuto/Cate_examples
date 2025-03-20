#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;

struct Sprite {
    byte y, x, pattern;
};
Sprite[SpriteCount] Sprites;


void HideAllSprites() 
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    byte y = pMovable->y - topY;
    if (y < WindowHeight) {
        pSprite->x = (pMovable->x << CoordShift) + pMovable->xd;
        pSprite->y = (y << CoordShift) + pMovable->yd;
        pSprite->pattern = pattern;
    }
    else {
        pSprite->pattern = InvalidPattern;    
    }
}


void HideSprite(byte index)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->pattern = InvalidPattern;
}
