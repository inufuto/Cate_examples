#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte Invalidpattern = 0xff;
constexpr byte MaxX = (VVramWidth - 2) * CoordRate;
constexpr byte MaxY = (VVramHeight - 2) * CoordRate;

struct Sprite {
    byte x, y, pattern;
    byte oldX, oldY, oldPattern;
};
Sprite[Sprite_End] Sprites;

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
    byte x;
    p = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    if (x < VVramWidth - 1) {
        x <<= CoordShift;
        p->x = x - DotOffset + pMovable->xd;
        p->y = pMovable->y + 8;
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
        if (p->oldPattern != Invalidpattern && p->oldY <= MaxY && p->oldX <= MaxX) {
            EraseBackup(p->oldX, p->oldY);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + Sprite_End - 1;
    repeat (Sprite_End) {
        if (p->pattern != Invalidpattern && p->y <= MaxY && p->x <= MaxX) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
        --p;
    }
}
