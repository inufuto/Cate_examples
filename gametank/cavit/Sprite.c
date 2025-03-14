#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;

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


void ShowSprite(byte index, byte x, byte y, byte pattern)
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
    p = Sprites + Sprite_Box;
    repeat (SpriteCount - Sprite_Box) {
        if (p->pattern != InvalidPattern) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        ++p;
    }
    p = Sprites;
    repeat (Sprite_Box) {
        if (p->pattern != InvalidPattern) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        ++p;
    }
}
