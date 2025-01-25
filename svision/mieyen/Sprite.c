#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

extern void _deb();

constexpr byte InvalidPattern = 0xff;

struct Element {
    byte x, y, pattern;
};
struct Sprite {
    Element now;
    Element old;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.pattern = InvalidPattern;
        p->old.pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->now.x = pMovable->x - CoordRate;
    p->now.y = pMovable->y + CoordRate;
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
        if (p->old.pattern != InvalidPattern) {
            byte y = p->old.y - StatusHeight * CoordRate;
            if (y < VVramHeight * CoordRate) {
                EraseBackup(p->old.x, y);
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End-1;
    repeat (Sprite_End) {
        byte pattern = p->now.pattern;
        if (pattern != InvalidPattern) {
            byte y = p->now.y;
            if (y < VramHeight * CoordRate) {
                DrawSprite(p->now.x, y, pattern);
            }
        }
        p->old.x = p->now.x;
        p->old.y = p->now.y;
        p->old.pattern = pattern;
        --p;
    }
    // DrawSprite(0, 0, 0);
    // DrawSprite(1, 1, 0);
    // DrawSprite(2, 2, 0);
    // DrawSprite(3, 3, 0);
}
