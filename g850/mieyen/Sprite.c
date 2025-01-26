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
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x - 1;
    p->y = pMovable->y - 1;
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
            ptr<byte> pVVram;
            byte x, y, c;
            x = p->x;
            y = p->y;
            pVVram = VVramFront + VVramOffset(x, y + 1);
            c = p->pattern;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            *pVVram = c;
                        }
                        ++pVVram;
                        ++c;
                        ++x;
                    }
                    x -= 2;
                    pVVram -= 2;
                }
                else {
                    c += 2;
                }
                pVVram += VVramWidth;
                ++y;
            }
        }
    }
}
