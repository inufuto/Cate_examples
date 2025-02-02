#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Bullet.h"

constexpr byte InvalidCode = 0xff;
Sprite[SpriteCount] Sprites;


void InitSprites()
{
    HideAllSprites();
}

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
            word offset, next;
            ptr<byte> pFront, pBack;
            if (p->oldCode >= Char_Bullet) {
                offset = VVramOffset(p->oldX >> BulletShift, p->oldY >> BulletShift);
                pFront = VVramFront + offset;
                pBack = VVramBack + offset;
                *pFront = *pBack;
            }
            else {
                offset = VVramOffset(p->oldX, p->oldY);
                pFront = VVramFront + offset;
                pBack = VVramBack + offset;
                if (p->oldX == VVramWidth - 1) {
                    repeat (2) {
                        *pFront = *pBack;
                        pFront += VVramWidth;
                        pBack += VVramWidth;
                    }
                }
                else {
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
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pFront;
            byte c;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            c = p->code;
            if (p->code >= Char_Bullet) {
                pFront = VVramFront + VVramOffset(p->x >> BulletShift, p->y >> BulletShift);
                *pFront = c; 
            }
            else {
                pFront = VVramFront + VVramOffset(p->x, p->y);
                if (p->x == VVramWidth - 1) {
                    repeat (2) {
                        *pFront = c;
                        c += 2;
                        pFront += VVramWidth;
                    }
                }
                else {
                    repeat (2) {
                        repeat (2) {
                            *pFront = c;
                            ++c;
                            ++pFront;
                        }
                        pFront += VVramWidth - 2;
                    }
                }
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
