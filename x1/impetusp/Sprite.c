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
    Element old0;
    Element old1;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.y = InvalidY;
        p->old0.y = InvalidY;
        p->old1.y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->now.x = pMovable->x;
    p->now.y = pMovable->y;
    p->pattern = pattern;
    PollVSync();
}


void ShowSpriteXY(byte index, byte x, byte y, byte pattern)
{
    ptr<Sprite> p = Sprites + index;
    p->now.x = x;
    p->now.y = y;
    p->pattern = pattern;
    PollVSync();
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
            p->old1.y < RangeY && p->old1.x < RangeX
        ) {
            EraseSprite(p->old1.x, p->old1.y);
        }
        if (
            p->old0.y < RangeY ||
            p->old1.y < RangeY
        ) {
            p->old1.x = p->old0.x;
            p->old1.y = p->old0.y;
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
            byte pattern = p->pattern;
            if (pattern < Pattern_Barrier) {
                DrawSprite1(p->now.x, p->now.y, pattern);    
            }
            else {
                DrawSprite2(p->now.x, p->now.y, pattern);
            }
        }
        if (
            p->now.y < RangeY ||
            p->old0.y < RangeY
        ) {
            p->old0.x = p->now.x;
            p->old0.y = p->now.y;
        }
    }
}
