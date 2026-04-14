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


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->chars;
    byte c = (pattern << 2) + Char_Sprite;
    repeat (4) {
        *p = c;
        ++p;
        ++c;
    }
}

void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
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
                    byte c = *pChars; ++pChars;
                    if (c != 0) {
                        *pVVram = c;
                    }
                    ++pVVram;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}
