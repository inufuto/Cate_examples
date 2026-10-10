#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
struct Sprite {
    byte x, y;
    byte pattern;
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
    ptr<Sprite> pSprite;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->pattern = InvalidPattern;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->pattern != InvalidPattern) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
