#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

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
    p->now.x = pMovable->x;
    p->now.y = pMovable->y;
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
            EraseBackup(p->old.x, p->old.y);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->now.pattern != InvalidPattern) {
            DrawSprite(p->now.x, p->now.y, p->now.pattern);
        }
        p->old.x = p->now.x;
        p->old.y = p->now.y;
        p->old.pattern = p->now.pattern;
    }
}
