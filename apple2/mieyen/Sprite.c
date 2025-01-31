#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte Invalidpattern = 0xff;

struct Element {
    byte x, y, pattern;
};
struct Sprite {
    Element now;
    Element old0;
    Element old1;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.pattern = Invalidpattern;
        p->old0.pattern = Invalidpattern;
        p->old1.pattern = Invalidpattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->now.x = pMovable->x;
    p->now.y = pMovable->y;
    p->now.pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.pattern = Invalidpattern;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->old1.pattern != Invalidpattern) {
            byte y = p->old1.y;
            if (y < VVramHeight * CoordRate) {
                EraseBackup(p->old1.x, y);
            }
        }
        if (p->old0.pattern != Invalidpattern) {
            p->old1.x = p->old0.x;
            p->old1.y = p->old0.y;
            p->old1.pattern = p->old0.pattern;
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        byte pattern = p->now.pattern;
        if (pattern != Invalidpattern) {
            byte y = p->now.y;
            if (y < VVramHeight * CoordRate) {
                DrawSprite(p->now.x, y, pattern);
            }
        }
        p->old0.x = p->now.x;
        p->old0.y = p->now.y;
        p->old0.pattern = pattern;
    }
}
