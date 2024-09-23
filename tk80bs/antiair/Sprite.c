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
            ptr<byte> pChar = pSprite->codes;
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
