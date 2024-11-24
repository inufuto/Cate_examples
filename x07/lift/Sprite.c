#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xff;
struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[SpriteCount] Sprites;

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
            ptr<byte> pVVram;
            ptr<byte> pChars;
            pVVram = VVramPtr(p->x, p->y);
            pChars = p->chars;
            pVVram[0] = *pChars; 
            ++pChars; pVVram[1] = *pChars;
            if (p->y < VVramHeight - 1) {
                ++pChars; pVVram[VVramWidth] = *pChars;
                ++pChars; pVVram[VVramWidth + 1] = *pChars;
            }
        }
    }
}
