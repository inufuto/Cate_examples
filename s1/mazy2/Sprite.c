#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"

constexpr byte WindowWidth = 32;
constexpr byte WindowHeight = 25;
constexpr byte InvalidPattern = 0xff;
constexpr byte RangeY = WindowHeight * CoordRate;

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
    p = Sprites + pMovable->sprite;
    p->now.x = pMovable->x;
    p->now.y = pMovable->y + (StageTop * CoordRate);
    p->now.pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.pattern = InvalidPattern;
}


static void EraseSprites()
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


static void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->now.pattern != InvalidPattern && p->now.y < RangeY) {
            DrawSprite(p->now.x, p->now.y, p->now.pattern);
            // DrawSprite(1, 1, p->now.pattern);
        }
        p->old0.x = p->now.x;
        p->old0.y = p->now.y;
        p->old0.pattern = p->now.pattern;
    }
}


void UpdateSprites() {
    EraseSprites();
    DrawSprites();
    SwitchGVram();
}
