#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
        p->oldPattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    byte y;
    p = Sprites + pMovable->sprite;
    y = pMovable->y - topY;
    if (y < VVramHeight) {
        p->x = pMovable->x;
        p->y = y;
        p->pattern = pattern;
    }
    else {
        p->pattern = InvalidPattern;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = InvalidPattern;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldPattern != InvalidPattern && p->oldY <= MaxY) {
            EraseBackup(p->oldX, p->oldY);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->pattern != InvalidPattern && p->y <= MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
        --p;
    }
}
