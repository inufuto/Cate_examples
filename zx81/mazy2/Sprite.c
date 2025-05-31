#include "Sprite.h"
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
            ptr<byte> pVram = VramPtr(pSprite->x, pSprite->y + StatusHeight);
            ptr<byte> pChar = pSprite->codes;
            repeat (2) {
                repeat (2) {
                    byte c =*pChar;
                    if (c != 0) {
                        *pVram = c;
                    }
                    ++pVram;
                    ++pChar;
                }
                pVram += VramRowSize - 2;
            }
        }
    }
}
