#include "Sprite.h"
#include "Vram.h"
#include "Coord.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte RangeX = (WindowWidth - 2) * CoordRate;
constexpr byte RangeY = (WindowHeight - 2) * CoordRate;

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


void ShowSprite(byte index, byte x, byte y, sbyte pattern)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = x;
    p->y = y;
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
        if (p->pattern != InvalidPattern && p->y <= RangeY && p->x <= RangeX) {
            DrawSprite(p->x, p->y, p->pattern);
        }
    }
}
