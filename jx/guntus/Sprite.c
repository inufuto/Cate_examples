#include "Sprite.h"
#include "Vram.h"
#include "Coord.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte RangeX = (WindowWidth - 2) * CoordRate;
constexpr byte RangeY = (WindowHeight - 2) * CoordRate;

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
    for (pSprite : Sprites) {
        if (pSprite->pattern != InvalidPattern && pSprite->y <= RangeY && pSprite->x <= RangeX) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
