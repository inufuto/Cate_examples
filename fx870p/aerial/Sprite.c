#include "Sprite.h"
#include "VVram.h"
#include "Bullet.h"

constexpr byte InvalidY = 0xff;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte[4] chars;
};
Sprite[SpriteCount] Sprites;


void InitSprites()
{
    HideAllSprites();
}

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
        pSprite->oldY = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite;
    ptr<byte> p;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    p = pSprite->chars;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void EraseSprites() 
{
    ptr<Sprite> pSprite;
    byte index;
    index = 0;
    for (pSprite : Sprites) {
        if (pSprite->oldY != InvalidY) {
            word offset;
            ptr<byte> pFront, pBack;
            if (index >= Sprite_MyBullet && index < Sprite_Bang) {
                offset = VVramOffset(pSprite->oldX >> BulletShift, pSprite->oldY >> BulletShift);
                pFront = VVramFront + offset;
                pBack = VVramBack + offset;
                *pFront = *pBack;
            }
            else {
                offset = VVramOffset(pSprite->oldX, pSprite->oldY);
                pFront = VVramFront + offset;
                pBack = VVramBack + offset;
                if (pSprite->oldX == VVramWidth - 1) {
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
        ++index;
    }
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    byte index;
    index = 0;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            ptr<byte> pFront, pChars;
            pChars = pSprite->chars;
            if (index >= Sprite_MyBullet && index < Sprite_Bang) {
                pFront = VVramFront + VVramOffset(pSprite->x >> BulletShift, pSprite->y >> BulletShift);
                *pFront = *pChars; 
            }
            else {
                pFront = VVramFront + VVramOffset(pSprite->x, pSprite->y);
                if (pSprite->x == VVramWidth - 1) {
                    repeat (2) {
                        *pFront = *pChars;
                        pChars += 2;
                        pFront += VVramWidth;
                    }
                }
                else {
                    repeat (2) {
                        repeat (2) {
                            *pFront = *pChars;
                            ++pChars;
                            ++pFront;
                        }
                        pFront += VVramWidth - 2;
                    }
                }
            }
        }
        pSprite->oldX = pSprite->x;
        pSprite->oldY = pSprite->y;
        ++index;
    }
}
