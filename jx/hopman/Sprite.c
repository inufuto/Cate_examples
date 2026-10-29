#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxX = (VVramWidth - 2) * CoordRate;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

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
    byte x;
    pSprite = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    if (x < VVramWidth - 1) {
        x <<= CoordShift;
        pSprite->x = x - DotOffset + pMovable->xd;
        pSprite->y = pMovable->y + CoordRate * 2;
        pSprite->pattern = pattern;
    }
    else {
        pSprite->pattern = InvalidPattern;    
    }
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
    pSprite = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --pSprite;
        if (pSprite->pattern != InvalidPattern && pSprite->y <= MaxY && pSprite->x <= MaxX) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
