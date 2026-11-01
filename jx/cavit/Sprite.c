#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

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


void ShowSprite(byte index, byte x, byte y, byte pattern)
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
        if (pSprite->pattern != InvalidPattern && pSprite->y <= MaxY) {
            DrawSprite(pSprite->x, pSprite->y, pSprite->pattern);
        }
    }
}
