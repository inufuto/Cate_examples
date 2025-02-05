#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0x80;
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


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
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


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            ptr<byte> pVVram, pChar;
            byte x, y;
            x = pSprite->x;
            y = pSprite->y;
            pVVram = VVramFront + VVramOffset(x + 1, y + 1) - (VVramWidth + 1);
            pChar = pSprite->chars;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            *pVVram = *pChar;
                        }
                        ++pVVram;
                        ++pChar;
                        ++x;
                    }
                    x -= 2;
                    pVVram -= 2;
                }
                else {
                    pChar += 2;
                }
                pVVram += VVramWidth;
                ++y;
            }
        }
    }
}
