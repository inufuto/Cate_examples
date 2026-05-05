#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

constexpr byte RangeX = (VVramWidth - 2) * CoordRate + 1;
constexpr byte RangeY = (VVramHeight - 2) * CoordRate + 1;
constexpr byte InvalidY = 0xe0;

struct Element {
    byte x, y;
};
struct Sprite {
    byte pattern;
    Element now;
    Element old;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.y = InvalidY;
        p->old.y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->now.x = pMovable->x;
    p->now.y = pMovable->y;
    p->pattern = pattern;
}


void ShowSpriteXY(byte index, byte x, byte y, byte pattern)
{
    ptr<Sprite> p = Sprites + index;
    p->now.x = x;
    p->now.y = y;
    p->pattern = pattern;
}

void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.y = InvalidY;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (
            p->old.y < RangeY && p->old.x < RangeX
        ) {
            EraseBackup(p->old.x, p->old.y);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --p;
        if (
            p->now.y < RangeY && p->now.x < RangeX
        ) {
            DrawSprite(p->now.x, p->now.y, p->pattern);
        }
        if (
            p->now.y < RangeY ||
            p->old.y < RangeY
        ) {
            p->old.x = p->now.x;
            p->old.y = p->now.y;
        }
    }
}
