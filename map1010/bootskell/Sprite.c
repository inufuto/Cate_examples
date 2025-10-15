#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidCode = 0xff;
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->code = InvalidCode;
        p->oldCode = InvalidCode;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->code = code;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->code = InvalidCode;
}


void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldCode != InvalidCode && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->code == InvalidCode
        )) {
            word offset;
            ptr<byte> pFront, pBack;
            byte y;
            y = p->oldY;
            offset = VVramOffset(p->oldX, y);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            pFront[1] = pBack[1];
            pFront[VVramWidth] = pBack[VVramWidth];
            pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
            SetRowFlags(y, 3);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pFront;
            byte y, c;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            y = p->y;
            pFront = VVramFront + VVramOffset(p->x, y);
            c = p->code;
            pFront[0] = c; 
            ++c; pFront[1] = c;
            ++c; pFront[VVramWidth] = c;
            ++c; pFront[VVramWidth + 1] = c;
            if (changed) {
                SetRowFlags(y, 3);
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
