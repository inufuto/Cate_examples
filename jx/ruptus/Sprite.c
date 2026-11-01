#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte CoordRate = 4;
constexpr byte InvalidPattern = 0xff;
constexpr byte MaxX = VVramWidth * CoordRate - CoordRate * 2;
constexpr byte MaxY = VVramHeight * CoordRate - CoordRate * 2;

struct Sprite {
    byte x, y, pattern;
};
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->pattern = InvalidPattern;
    }
}


void ShowSprite(byte index, byte x, byte y, sbyte pattern)
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->x = x;
    pSprite->y = y;
    pSprite->pattern = pattern;
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
    pSprite = Sprites + SpriteCount;
    repeat (SpriteCount) {
        --pSprite;
        if (pSprite->pattern != InvalidPattern && pSprite->y <= MaxY && pSprite->x <= MaxX) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
