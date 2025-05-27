#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;

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
            DrawSprite(p->x, p->y, p->pattern);
                                    // DrawSprite(0+1, 0+1, 6);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}
