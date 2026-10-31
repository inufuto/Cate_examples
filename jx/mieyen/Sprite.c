#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
// constexpr byte MaxY = VramHeight * CharHeight - CharHeight * 2;

struct Sprite {
    byte x, y, pattern;
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
