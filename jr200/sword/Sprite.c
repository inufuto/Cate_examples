#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
    }
}


void ShowSpriteC(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    byte y = pMovable->y;
    if (y >= VVramHeight - 1) {
        pSprite->y = InvalidY;
        return;
    }
    pSprite->y = y;
    pSprite->x = pMovable->x;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = c;
        ++p;
        ++c;
    }
}

void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    byte y = pMovable->y;
    if (y >= VVramHeight - 1) {
        y = InvalidY;
    }
    pSprite->y = y;
    pSprite->x = pMovable->x;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
    }
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
            ptr<byte> pChars = pSprite->chars;
            repeat (2) {
                repeat (2) {
                    byte c = *pChars;
                    if (c != Char_Space) {
                        *pVVram = c;
                    }
                    ++pVVram;
                    ++pChars;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}
