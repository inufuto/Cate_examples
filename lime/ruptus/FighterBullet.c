#include "FighterBullet.h"
#include "Sprite.h"
#include "Fighter.h"
#include "Stage.h"
#include "VVram.h"
#include "Chars.h"
#include "Direction.h"
#include "Enemy.h"
#include "Main.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sound.h"

constexpr byte MaxCount = 4;
constexpr byte SpriteColor = 15;
constexpr byte HiVelocity = 100;
constexpr byte LoVelocity = HiVelocity * 70 / 100;
constexpr byte Interval = 20;
constexpr byte InvalidSprite = 0x80;

static FighterBullet[MaxCount] Bullets;
static byte IntervalCount;

void InitFighterBullets() 
{
    ptr<FighterBullet> pBullet;
    for (pBullet : Bullets) {
        pBullet->sprite = InvalidSprite;
    }
    IntervalCount = Interval;
}


static void Locate(ptr<FighterBullet> pBullet)
{
    byte x, y;
    x = OffsetX(pBullet->x);
    if (x >= VVramWidth) goto end;
    y = OffsetY(pBullet->y);
    if (y >= VVramHeight) goto end;
    ShowSprite(pBullet->sprite, x, y, pBullet->code);
    return;
end:
    HideSprite(pBullet->sprite);
    pBullet->sprite = InvalidSprite;
}

static bool Start(byte direction) 
{
    ptr<Direction> pDirection;
    ptr<Direction> pOffset;
    direction &= 7;
    pDirection  = Directions + direction;
    pOffset = BulletOffsets + direction;

    {
        byte sprite;
        ptr<FighterBullet> pBullet;
        sprite = Sprite_FighterBullet;
        for (pBullet : Bullets) {
            if (pBullet->sprite != InvalidSprite) goto next;
            Sound_Fire();
            pBullet->x = FighterX + pOffset->dx;
            pBullet->y = FighterY + pOffset->dy;
            pBullet->dx = pDirection->dx;
            pBullet->dy = pDirection->dy;
            pBullet->direction = direction;
            pBullet->code = Pattern_FighterBullet + (direction & 3);
            pBullet->sprite = sprite;
            pBullet->numerator = (direction & 1) == 0 ? HiVelocity : LoVelocity;
            pBullet->denominator = 0;
            Locate(pBullet);
            return true;
        next:
            ++sprite;
        }
    }
    return false;
}


void StartFighterBullet(bool on) 
{
    if (IntervalCount != 0) {
        --IntervalCount;
        return;
    }
    if (!on) {
        // IntervalCount = 0;
        return;
    }
    IntervalCount = Interval;

    Start(FighterDirection);
}

static bool Hit(ptr<FighterBullet> pBullet)
{
    ptr<Direction> pDirection;
    byte x, y;
    pDirection = BulletOffsets + pBullet->direction;
    x = pBullet->x - pDirection->dx;
    y = pBullet->y - pDirection->dy;

    if(HitEnemy(pBullet->x, pBullet->y, 0)) {
        return true;
    }
    if (HitBarrier(x, y, 1)) {
        return true;
    }
    if (HitFort(x, y, 1)) {
        return true;
    }
    return false;
}

void MoveFighterBullets()
{
    ptr<FighterBullet> pBullet;
    for (pBullet : Bullets) {
        sbyte dx, dy;
        byte direction;
        ptr<Direction> pDirection;

        if (pBullet->sprite == InvalidSprite) continue;
        if (HitEnemy(pBullet->x, pBullet->y, 0)) {
            goto end;
        }
        if ((Clock & 1) == 0) {
            pBullet->denominator -= pBullet->numerator;
            if (pBullet->denominator >= 0) goto locate;
        
            pBullet->x = AddX(pBullet->x, pBullet->dx);
            pBullet->y = AddY(pBullet->y, pBullet->dy);
            pBullet->denominator += 100;
        }
        if (Hit(pBullet)) {
            end:
            HideSprite(pBullet->sprite);
            pBullet->sprite = InvalidSprite;
            continue;
        }
    locate:
        Locate(pBullet);
    }
}
