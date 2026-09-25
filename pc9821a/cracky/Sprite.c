#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

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


void DrawSprites()
{
    ptr<Sprite> pSprite = Sprites + SpriteCount;
    repeat (SpriteCount) {
        --pSprite;
        if (pSprite->pattern != InvalidPattern && pSprite->y <= MaxY) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
