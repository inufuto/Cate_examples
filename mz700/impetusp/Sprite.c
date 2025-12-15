#include "Movable.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"

constexpr byte InvalidY = 0xe0;

struct Sprite {
    byte x, y;
    byte pattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->pattern = pattern;
}


void ShowSpriteXY(byte index, byte x, byte y, byte pattern)
{
    ptr<Sprite> p = Sprites + index;
    p->x = x;
    p->y = y;
    p->pattern = pattern;
    // PollVSync();
}

void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --p;
        byte y = p->y;
        if (y != InvalidY) {
            DrawSprite(p->x, y, p->pattern);
        }
    }
}
