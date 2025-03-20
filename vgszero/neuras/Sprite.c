#include "Sprite.h"

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


void ShowSprite(byte index, byte x, byte y, sbyte pattern)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->x = x;
    pSprite->y = y;
    pSprite->pattern = pattern;
}


void HideSprite(byte index)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->pattern = InvalidPattern;
}
