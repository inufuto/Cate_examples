#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "Card.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte c;
};
Sprite[SpriteCount] Sprites;

void ShowSprite(byte index, byte x, byte y, sbyte pattern) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->x = (x + 4) >> 3;
    pSprite->y = (y + 4) >> 3;
    pSprite->c = pattern;
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
        byte x = pSprite->oldX;
        byte y = pSprite->oldY;
        if (
            pSprite->oldY != InvalidY &&
            (pSprite->x != x || pSprite->y != y)
        ) {
            DrawBackground(x, y);
        }
    }
}

void DrawSprites() 
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        byte y = pSprite->y;
        if (y != InvalidY) {
            Put2CXYOver(pSprite->x, y, pSprite->c);
        }
        pSprite->oldX = pSprite->x;
        pSprite->oldY = pSprite->y;
    }
}

void InitSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
        pSprite->oldY = InvalidY;
    }
}
