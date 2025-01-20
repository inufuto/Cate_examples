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
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    p = pSprite->codes;
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
            ptr<byte> pVram, pChar;
            byte x, y;
            x = pSprite->x;
            y = pSprite->y;
            pVram = VramPtr(x, y + StatusHeight);
            pChar = pSprite->codes;
            repeat (2) {
                if (y < VramHeight) {
                    repeat (2) {
                        if (x < VramWidth) {
                            *pVram = *pChar;
                        }
                        ++pVram;
                        ++pChar;
                        ++x;
                    }
                    x -= 2;
                    pVram -= 2;
                }
                else {
                    pChar += 2;
                }
                pVram += VramRowSize;
                ++y;
            }
        }
    }
}
