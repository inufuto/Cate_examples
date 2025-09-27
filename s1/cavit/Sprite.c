#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = (VramHeight - 1) * CoordRate;

struct Element {
    byte x, y, pattern;
};
struct Sprite {
    Element now;
    Element old0;
    Element old1;
};
Sprite[SpriteCount] Sprites;

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


void ShowSprite(byte index, byte x, byte y, byte pattern)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.x = x;
    p->now.y = y + CoordRate;
    p->now.pattern = pattern;
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
        if (p->old1.pattern != InvalidPattern && p->old1.y < MaxY) {
            EraseSprite(p->old1.x, p->old1.y);
        }
        if (p->old0.pattern != InvalidPattern && p->old0.y < MaxY) {
            p->old1.x = p->old0.x;
            p->old1.y = p->old0.y;
            p->old1.pattern = p->old0.pattern;
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->now.pattern != InvalidPattern && p->now.y < MaxY) {
            DrawSprite(p->now.x, p->now.y, p->now.pattern);
        }
        p->old0.x = p->now.x;
        p->old0.y = p->now.y;
        p->old0.pattern = p->now.pattern;
        --p;
    }
}
