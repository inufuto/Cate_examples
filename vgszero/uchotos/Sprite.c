#include "Sprite.h"

constexpr byte InvalidPattern = 0xff;

struct Sprite {
    byte y, x, pattern;
};
Sprite[Sprite_End] Sprites;


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
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->pattern = pattern;
}


void HideSprite(byte index)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->pattern = InvalidPattern;
}
