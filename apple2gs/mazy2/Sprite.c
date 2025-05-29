#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
// constexpr byte MaxY = VramHeight * CharHeight - CharHeight * 2;

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
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->pattern = pattern;
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
        if (p->pattern != InvalidPattern) {
            DrawSprite(p->x << 1, p->y << 1, p->pattern);
        }
    }
}
