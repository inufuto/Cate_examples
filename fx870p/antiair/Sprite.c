#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"

constexpr byte InvalidY = 0xff;

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
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->y != InvalidY) {
            ptr<byte> pVVram, pChars;
            byte x, y;
            x = p->x;
            y = p->y;
            pVVram = VVramPtr(x, y);
            pChars = p->chars;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            byte b;
                            b = *pChars;
                            if (b != 0) {
                                *pVVram = b;
                            }
                        }
                        ++pVVram;
                        ++pChars;
                        ++x;
                    }
                    x -= 2;
                    pVVram -= 2;
                }
                else {
                    pChars += 2;
                }
                pVVram += VVramWidth;
                ++y;
            }
        }
    }
}
