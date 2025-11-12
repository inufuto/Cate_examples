#include "Movable.h"
#include "Sprite.h"
#include "VVram.h"

constexpr byte InvalidY = 0xe0;

struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
    }
}


void ShowSprite1(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->chars;
    *p = c;
    ++p;
    repeat (3) {
        *p = 0;
        ++p;
    }
}


void ShowSprite2(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = c;
        ++p;
        ++c;
    }
}


void ShowSpriteXY(byte index, byte x, byte y, byte c)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->x = x;
    pSprite->y = y;
    ptr<byte> p = pSprite->chars;
    repeat (2) {
        *p = c;
        ++p;
        ++c;
    }
    repeat (2) {
        *p = 0;
        ++p;
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
        byte y = pSprite->y;
        ptr<byte> p = pSprite->chars;
        ptr<byte> pVVram = (VVramFront - VVramWidth * 2) + VVramOffset(pSprite->x, y + 2);
        repeat (2) {
            if (y < VVramHeight) {
                repeat (2) {
                    byte c = *p; ++p;
                    if (c != 0) {
                        *pVVram = c;
                    }
                    ++pVVram;
                }
                pVVram += VVramWidth - 2;
            }
            else {
                pVVram += VVramWidth;
                p += 2;
            }
            ++y;
        }
    }
}
