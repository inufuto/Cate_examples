#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte Invalidpattern = 0xff;
constexpr byte MaxY = VVramHeight * 8 - 16;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = Invalidpattern;
        p->oldPattern = Invalidpattern;
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
    p->pattern = Invalidpattern;
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->pattern != Invalidpattern && p->y <= MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
        --p;
    }
}
