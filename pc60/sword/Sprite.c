#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte c;
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
    p->c = (pattern << 2) + Char_Sprite;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p = Sprites + index;
    p->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites;
    repeat (Sprite_End) {
        --p;
        if (p->y <= VVramHeight - 1) {
            ptr<byte> pVVram = VVramFront + VVramOffset(p->x, p->y);
            byte c = p->c;
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
