#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidPattern = 0xff;
struct Sprite {
    byte x, y;
    byte pattern;
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
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p = Sprites + index;
    p->pattern = InvalidPattern;
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidPattern) {
            ptr<byte> pVVram = VVramFront + VVramOffset(p->x, p->y);
            byte c = p->pattern;
            if (c < Char_Man) {
                *pVVram = c;
            }
            else {
                repeat (2) {
                    repeat (2) {
                        *pVVram = c;
                        ++pVVram;
                        ++c;
                    }
                    pVVram += VVramWidth - 2;
                }
            }
        }
    }
}
