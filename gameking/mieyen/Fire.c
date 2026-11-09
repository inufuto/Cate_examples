#include "Fire.h"
#include "Sprite.h"
#include "Sound.h"
#include "Chars.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"

extern void _deb();

constexpr byte SpriteColor = 13;
constexpr byte Fire_Moving = 0x40;
constexpr byte Fire_PointMask = 0x30;

// static const byte[4] SpriteColors = { 8, 11, 10, 9 };
Fire[MaxFireCount] Fires;
byte FireTime;
static byte Clock;

void InitFires()
{
    byte sprite = Sprite_Fire;
    ptr<Fire> pFire;
    for (pFire: Fires) {
        pFire->status = 0;
        pFire->sprite = sprite;
        ++sprite;
    }
}


void StartFire()
{
    ptr<Fire> pFire;
    for (pFire: Fires) {
        if ((pFire->status & Movable_Live) == 0) {
            pFire->status = Movable_Live | Fire_Moving;
            pFire->x = Man.x;
            pFire->y = Man.y;
            pFire->dx = pManDirection->dx;
            pFire->dy = pManDirection->dy;
            pFire->time = FireTime;
            Sound_Fire();
            break;
        }
    }
}


static bool Hit(ptr<Fire> pFire)
{
    ptr<Monster> pMonster = HitMonster(pFire);
    if (pMonster != nullptr) {
        byte status = pFire->status;
        byte rate = status & Fire_PointMask;
        StartPoint(pMonster->x, pMonster->y, rate >> 4);
        pFire->status = (status & ~Fire_PointMask) | ((rate + 0x10) & Fire_PointMask);
        Sound_Hit();
        return true;
    }
    return false;
}

void MoveFires()
{
    ptr<Fire> pFire;
    for (pFire: Fires) {
        byte status = pFire->status;
        if ((status & Movable_Live) != 0) {
            byte pattern;
            if ((status & Fire_Moving) != 0) {
                if (((pFire->x | pFire->y) & CoordMask) == 0) {
                    if (
                        --pFire->time == 0 || 
                        !CanMove(pFire, pFire->dx, pFire->dy)
                    ) {
                        pFire->status &= ~Fire_Moving;
                        pFire->time = FireTime << 2;
                        pattern = Pattern_Fire;
                        goto show;
                    }
                }
                MoveMovable(pFire);
                pattern = Pattern_FireBullet;
            }
            else {
                if ((Clock & CoordMask) == 0) {
                    if (--pFire->time == 0) {
                        pFire->status &= ~Movable_Live;
                        HideSprite(pFire->sprite);
                        goto next;
                    }
                }
                pattern = Pattern_Fire;
            }
            show:
            ShowSprite(pFire, pattern);
            Hit(pFire);
        }
        next:;
    }
    ++Clock;
}