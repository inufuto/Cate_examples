#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = (WindowHeight - 2) * CoordRate + 1;

struct Sprite {
    byte x, y, pattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    byte y;
    p = Sprites + pMovable->sprite;
    y = pMovable->y - topY;
    if (y < WindowHeight) {
        p->x = (pMovable->x << CoordShift) + pMovable->xd;
        p->y = (y << CoordShift) + pMovable->yd + dotOffset;
        p->pattern = pattern;
    }
    else {
        p->pattern = InvalidPattern;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = InvalidPattern;
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidPattern && p->y < MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
    }
}
