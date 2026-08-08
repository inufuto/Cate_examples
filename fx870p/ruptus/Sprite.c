#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xff;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte[4] chars;
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


void ShowSprite(byte index, byte x, byte y, ptr<byte> pChars)
{
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + index;
    pSprite->x = x;
    pSprite->y = y;
    p = pSprite->chars;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
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
        if (pSprite->oldY != InvalidY) {
            word offset;
            ptr<byte> pFront, pBack;
            offset = VVramOffset(pSprite->oldX, pSprite->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            repeat (2) {
                repeat (2) {
                    *pFront = *pBack;
                    ++pBack;
                    ++pFront;
                }
                pFront += VVramWidth - 2;
                pBack += VVramWidth - 2;
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            ptr<byte> pFront, pChars;
            pFront = VVramFront + VVramOffset(pSprite->x, pSprite->y);
            pChars = pSprite->chars;
            repeat (2) {
                repeat (2) {
                    byte c;
                    c = *pChars; ++pChars;
                    if (c != 0) {
                        *pFront = c;
                    }
                    ++pFront;
                }
                pFront += VVramWidth - 2;
            }
        }
        pSprite->oldX = pSprite->x;
        pSprite->oldY = pSprite->y;
    }
}
