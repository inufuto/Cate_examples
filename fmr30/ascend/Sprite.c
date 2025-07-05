#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte Invalidpattern = 0xff;
constexpr byte MaxY = VVramHeight * 8 - 16;

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


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p;
    byte y;
    p = Sprites + pMovable->sprite;
    y = pMovable->y - topY;
    if (y < VVramHeight) {
        p->x = (pMovable->x << CoordShift) + pMovable->xd;
        p->y = (y << CoordShift) + pMovable->yd + dotOffset;
        p->pattern = pattern;
    }
    else {
        p->pattern = Invalidpattern;
    }
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
        if (p->oldPattern != Invalidpattern && p->oldY <= MaxY) {
            EraseBackup(p->oldX, p->oldY);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->pattern != Invalidpattern && p->y <= MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
        --p;
    }
}
