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
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
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


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->y != InvalidY) {
            ptr<byte> pVVram, pChars;
            byte x, y;
            x = p->x;
            y = p->y;
            pVVram = VVramPtr(x + 1, y + 1) - (VVramWidth + 1);
            pChars = p->codes;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        byte c;
                        c = *pChars;
                        if (c != Char_Space && x < VVramWidth) {
                            *pVVram = c;
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
