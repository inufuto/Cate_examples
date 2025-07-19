#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte InvalidPattern = 0xff;

Sprite[SpriteCount] Sprites;

void ShowSprite(byte index, byte x, byte y, sbyte pattern) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = (x + 4) >> 3;
    p->y = (y + 4) >> 3;
    p->pattern = pattern;
}

void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = -1;
}

void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldPattern != InvalidPattern && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->pattern != InvalidPattern
        )) {
            word offset;
            ptr<byte> pFront, pBack;
            offset = VVramOffset(p->oldX, p->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            pFront[1] = pBack[1];
            pFront[32] = pBack[32];
            pFront[32 + 1] = pBack[32 + 1];
        }
    }
}

void DrawSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidPattern) {
            bool changed;
            ptr<byte> pFront;
            byte c;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldPattern != p->pattern;
            pFront = VVramFront + VVramOffset(p->x, p->y);
            c = p->pattern;
            pFront[0] = c++;
            pFront[1] = c++;
            pFront[32] = c++;
            pFront[32 + 1] = c++;
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}

void InitSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
        p->oldPattern = InvalidPattern;
    }
}
