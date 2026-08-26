#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;
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
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --pSprite;
        if (pSprite->y <= VVramHeight - 1) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pSprite->x, pSprite->y);
            byte c = (pSprite->pattern << 2) + Char_Sprite;
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
