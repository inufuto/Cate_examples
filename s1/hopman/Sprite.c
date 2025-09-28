#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte RangeY = VramHeight * CoordRate - CoordRate * 2 + 1;

struct Element {
    byte x, y, pattern;
};
struct Sprite {
    Element now;
    Element old0;
    Element old1;
};
Sprite[Sprite_End] Sprites;

void InitSprites()
{
    HideAllSprites();
}

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.pattern = InvalidPattern;
        p->old0.pattern = InvalidPattern;
        p->old1.pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    byte x;
    p = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    if (x < WindowWidth - 1) {
        x <<= CoordShift;
        p->now.x = x - DotOffset + pMovable->xd;
        p->now.y = pMovable->y + 4;
        p->now.pattern = pattern;
    }
    else {
        p->now.pattern = InvalidPattern;    
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.pattern = InvalidPattern;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->old1.pattern != InvalidPattern && p->old1.y < RangeY) {
            EraseSprite(p->old1.x, p->old1.y);
        }
        if (p->old0.pattern != InvalidPattern && p->old0.y < RangeY) {
            p->old1.x = p->old0.x;
            p->old1.y = p->old0.y;
            p->old1.pattern = p->old0.pattern;
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + Sprite_End - 1;
    repeat (Sprite_End) {
        if (p->now.pattern != InvalidPattern && p->now.y < RangeY) {
            DrawSprite(p->now.x, p->now.y, p->now.pattern);
        }
        p->old0.x = p->now.x;
        p->old0.y = p->now.y;
        p->old0.pattern = p->now.pattern;
        --p;
    }
}
