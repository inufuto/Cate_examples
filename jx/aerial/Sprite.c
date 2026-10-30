#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxX = (32 - 2) * CoordRate;
constexpr byte MaxY = (22 - 2) * CoordRate;

struct Sprite {
    byte x, y, pattern;
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
    pSprite = Sprites + SpriteCount;
    repeat (SpriteCount) {
        --pSprite;
        if (pSprite->pattern != InvalidPattern && pSprite->x <= MaxX && pSprite->y <= MaxY) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
