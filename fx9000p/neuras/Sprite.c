#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte InvalidCode = 0xff;

Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidCode;
        p->oldPattern = InvalidCode;
    }
}


void ShowSprite(byte index, byte x, byte y, sbyte pattern) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = ((x + 4) >> 3) - 1;
    p->y = ((y + 4) >> 3);
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
        if (p->oldPattern != InvalidCode && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->pattern == InvalidCode
        )) {
            word offset;
            ptr<byte> pFront, pBack;
            offset = VVramOffset(p->oldX, p->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            pFront[1] = pBack[1];
            pFront[VVramWidth] = pBack[VVramWidth];
            pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
        }
    }
}

void DrawSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidCode) {
            ptr<byte> pFront;
            byte c;
            pFront = VVramFront + VVramOffset(p->x, p->y);
            c = p->pattern;
            pFront[0] = c++;
            pFront[1] = c++;
            pFront[VVramWidth] = c++;
            pFront[VVramWidth + 1] = c++;
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}
