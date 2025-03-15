#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;

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


void ShowSprite(byte index, word x, byte y, byte pattern)
{
    ptr<Sprite> p = Sprites + index;
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
        if (p->pattern != InvalidPattern) {
            DrawSprite(p->x, p->y, p->pattern);
        }
    }
}
