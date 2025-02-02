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
            offset = VVramOffset(p->oldX, p->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            repeat (2) {
                repeat (2) {
                    *pFront = *pBack;
                    ++pFront;
                    ++pBack;
                }
                pFront += VVramWidth - 2;
                pBack += VVramWidth - 2;
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            ptr<byte> pFront;
            byte c;
            pFront = VVramFront + VVramOffset(p->x, p->y);
            c = p->code;
            repeat (2) {
                repeat (2) {
                    *pFront = c; ++pFront;
                    ++c;
                }
                pFront += VVramWidth - 2;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
