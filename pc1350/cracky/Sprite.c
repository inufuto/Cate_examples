#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"
#include "CopyMemory.h"

extern void _deb();

constexpr byte InvalidY = 0xff;

struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte[4] chars;
};
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
        p->oldY = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    CopyMemory(p->chars, pChars, 4);
}


void HideSprite(byte index) 
{
    ptr<Sprite> p = Sprites + index;
    p->y = InvalidY;
    p->oldY = InvalidY;
}


void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldY != InvalidY) {
            byte y = p->oldY;
            word offset = VVramOffset(p->oldX, y);
            ptr<byte> pFront = VVramFront + offset;
            ptr<byte> pBack = VVramBack + offset;
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
        byte y;
        y = p->y;
        if (y != InvalidY) {
            ptr<byte> pChars = p->chars;
            ptr<byte> pFront = VVramFront + VVramOffset(p->x, y);
            repeat (2) {
                repeat (2) {
                    *pFront = *pChars;
                    ++pFront;
                    ++pChars;
                }
                pFront += VVramWidth - 2;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
    }
}
