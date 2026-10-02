#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte Top = 2 * CoordRate;
constexpr byte RangeX = (VVramWidth - 2) * CoordRate + 1;
constexpr byte RangeY = (VVramHeight - 2) * CoordRate + 1;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
        p->oldPattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    byte x, y;
    p = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    y = pMovable->y + Top;
    if (x < VVramWidth - 1 && y < RangeY) {
        x = (x << CoordShift) + (pMovable->xd - DotOffset);
        p->x = x;
        p->y = y;
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


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldPattern != InvalidPattern && p->oldX < RangeX && p->oldY < RangeY) {
            EraseBackup(p->oldX, p->oldY);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + Sprite_End - 1;
    repeat (Sprite_End) {
        if (p->pattern != InvalidPattern && p->x < RangeX && p->y < RangeY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
        --p;
    }
}
