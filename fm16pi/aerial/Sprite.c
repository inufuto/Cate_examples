#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxX = (VVramWidth - 2) * CoordRate;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

struct Sprite {
    byte x, y, pattern;
};
Sprite[SpriteCount] Sprites;


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
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->pattern != InvalidPattern && p->x <= MaxX && p->y <= MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        --p;
    }
}
