#include "Sprite.h"
#include "Vram.h"

constexpr byte Invalidpattern = 0xff;
constexpr byte RangeX = (StageWidth - 2) * CoordRate;
constexpr byte RangeY = (StageHeight - 2) * CoordRate;

Sprite[SpriteCount] Sprites;

void InitSprites()
{
    HideAllSprites();
}

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = Invalidpattern;
        p->oldPattern = Invalidpattern;
    }
}


void ShowSprite(byte index, byte x, byte y, sbyte pattern)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = x;
    p->y = y;
    p->pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = Invalidpattern;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldPattern != Invalidpattern && p->oldY <= RangeY && p->oldX <= RangeX) {
            EraseBackup(p->oldX, p->oldY);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p = Sprites + SpriteCount;
    repeat(SpriteCount) {
        --p;
        if (p->pattern != Invalidpattern && p->y <= RangeY && p->x <= RangeX) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}
