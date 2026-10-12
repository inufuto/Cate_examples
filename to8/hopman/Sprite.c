#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
struct Sprite {
    byte x, y;
    byte pattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite;
    byte x, y;
    pSprite = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    y = pMovable->y;
    if (x < VVramWidth && y < VVramHeight) {
        pSprite->x = x;
        pSprite->y = y;
        pSprite->pattern = pattern;
    }
    else {
        pSprite->pattern = InvalidPattern;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->pattern = InvalidPattern;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (
            pSprite->pattern != InvalidPattern &&
            pSprite->x < VVramWidth - 1 &&
            pSprite->y < VVramHeight - 1
        ) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
