#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

constexpr byte RangeX1 = (VVramWidth - 1) * CoordRate + 1;
constexpr byte RangeX2= (VVramWidth - 2) * CoordRate + 1;
constexpr byte RangeY = (VVramHeight - 2) * CoordRate + 1;
constexpr byte InvalidY = 0xe0;

struct Sprite {
    byte x, y;
    byte pattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->pattern = pattern;
}


void ShowSpriteXY(byte index, byte x, byte y, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->x = x;
    pSprite->y = y;
    pSprite->pattern = pattern;
}

void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --p;
        if (
            p->y < RangeY &&
            p->x < RangeX1
        ) {
            byte pattern = p->pattern;
            if (pattern < Pattern_Barrier) {
                if (p->x < RangeX1) {
                    DrawSprite1(p->x, p->y, pattern);
                }
            }
            else {
                if (p->x < RangeX2) {
                    DrawSprite2(p->x, p->y, pattern);
                }
            }
        }
    }
}
