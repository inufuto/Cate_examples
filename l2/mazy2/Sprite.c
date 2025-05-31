#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0x80;
struct Sprite {
    byte x, y;
    byte[4] codes;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->codes;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
    }
}

void ShowSpriteC(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->codes;
    *p = c;
    ++p;
    repeat (3) {
        *p = 0;
        ++p;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pSprite->x, pSprite->y);
            ptr<byte> pChar = pSprite->codes;
            repeat (2) {
                repeat (2) {
                    byte c =*pChar;
                    if (c != 0) {
                        *pVVram = c;
                    }
                    ++pVVram;
                    ++pChar;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}
