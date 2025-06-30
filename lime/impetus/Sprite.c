#include "Sprite.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;
constexpr byte MaxY = VVramHeight - 2;

Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
        p->oldPattern = InvalidPattern;
    }
}


void ShowSprite(byte index, byte x, byte y, byte pattern)
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
    for (p : Sprites) {
        if (p->pattern != InvalidPattern && p->y <= MaxY) {
            DrawSprite(p->x, p->y, p->pattern);
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}
