#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte c;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
    }
}


void ShowSpriteC(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->c = c;
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --pSprite;
        if (pSprite->y != InvalidY) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pSprite->x, pSprite->y);
            byte c = pSprite->c;
            repeat (2) {
                repeat (2) {
                    *pVVram = c;
                    ++pVVram;
                    ++c;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}
