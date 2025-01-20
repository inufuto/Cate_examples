#include "Fire.h"
#include "Sprite.h"
// #include "Sound.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"

extern void _deb();

constexpr byte Fire_Moving = 0x40;
constexpr byte Fire_PointMask = 0x30;
constexpr byte MaxCount = Sprite_End - Sprite_Fire;

// static const byte[4] SpriteColors = { 8, 11, 10, 9 };
Fire[MaxCount] Fires;
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
            // Sound_Fire();
            break;
        }
    }
}


static bool Hit(ptr<Fire> pFire)
{
    ptr<Monster> pMonster = HitMonster(pFire);
                                    _deb();
    if (pMonster != nullptr) {
        byte status = pFire->status;
        byte rate = status & Fire_PointMask;
        StartPoint(pMonster->x, pMonster->y, rate >> 4);
        pFire->status = (status & ~Fire_PointMask) | ((rate + 0x10) & Fire_PointMask);
        // Sound_Hit();
        return true;
    }
    return false;
}

void MoveFires()
{
    static const byte[] FireChars = {
        0x81, 0x86, 0x86, 0x07,
    };
    static const byte[] FireBulletChars = {
        0x87, 0x00, 0x00, 0x01,
    };
    ptr<Fire> pFire;
    for (pFire: Fires) {
        byte status = pFire->status;
        if ((status & Movable_Live) != 0) {
            ptr<byte> pChars;
            if ((status & Fire_Moving) != 0) {
                if (((pFire->x | pFire->y) & CoordMask) == 0) {
                    if (
                        --pFire->time == 0 || 
                        !CanMove(pFire, pFire->dx, pFire->dy)
                    ) {
                        pFire->status &= ~Fire_Moving;
                        pFire->time = FireTime << 2;
                        pChars = FireChars;
                        goto show;
                    }
                }
                MoveMovable(pFire);
                pChars = FireBulletChars;
            }
            else {
                if ((Clock & CoordMask) == 0) {
                    if (--pFire->time == 0) {
                        pFire->status &= ~Movable_Live;
                        HideSprite(pFire->sprite);
                        goto next;
                    }
                }
                pChars = FireChars;
            }
            show:
            ShowSprite(pFire, pChars);
            Hit(pFire);
        }
        next:;
    }
    ++Clock;
}