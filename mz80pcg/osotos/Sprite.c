#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;
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


void ShowSpriteC(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->codes;
    repeat (4) {
        *p = code;
        ++p;
        ++code;
    }
}


void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pCodes)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->codes;
    repeat (4) {
        *p = *pCodes;
        ++p;
        ++pCodes;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            byte x = pSprite->x;
            byte y = pSprite->y;
            ptr<byte> pVVram = VVramPtr(x, y);
            ptr<byte> p = pSprite->codes;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            byte c = *p;
                            if ((c != 0)) {
                                *pVVram = c;
                            }
                        }
                        ++pVVram;
                        ++p;
                        ++x;
                    }
                    x -= 2;
                    pVVram -= 2;
                }
                else {
                    p += 2;
                }
                pVVram += VVramWidth;
                ++y;
            }
        }
    }
}
