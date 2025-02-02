#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte[4] codes;
};
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
        pSprite->oldY = InvalidY;
    }
}


void ShowSpriteC(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    p = pSprite->codes;
    repeat (4) {
        *p = code;
        ++p;
        ++code;
    }
}


void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pCodes)
{
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    p = pSprite->codes;
    repeat (4) {
        *p = *pCodes;
        ++p;
        ++pCodes;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void EraseSprites() 
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->oldY != InvalidY && (
            pSprite->oldX != pSprite->x || 
            pSprite->oldY != pSprite->y
        )) {
            word offset;
            ptr<byte> pFront, pBack;
            byte y;
            y = pSprite->oldY;
            offset = VVramOffset(pSprite->oldX, y);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            pFront[1] = pBack[1];
            pFront[VVramWidth] = pBack[VVramWidth];
            pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            ptr<byte> pFront, pChars;
            byte y;
            y = pSprite->y;
            pFront = VVramFront + VVramOffset(pSprite->x, y);
            pChars = pSprite->codes;
            repeat (2) {
                repeat (2) {
                    byte c;
                    c = *pChars;
                    if (c != Char_Space) {
                        *pFront = c;
                    }                   
                    ++pFront;
                    ++pChars;
                }
                pFront += VVramWidth - 2;
            }
        }
        pSprite->oldX = pSprite->x;
        pSprite->oldY = pSprite->y;
    }
}
