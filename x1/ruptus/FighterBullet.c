#include "FighterBullet.h"
#include "Sprite.h"
#include "Fighter.h"
#include "Stage.h"
#include "Window.h"
#include "Chars.h"
#include "Direction.h"
#include "Enemy.h"
#include "Main.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sound.h"

constexpr byte MaxCount = 4;
constexpr byte HalfSize = 1;
constexpr byte HiVelocity = 100;
constexpr byte LoVelocity = HiVelocity * 70 / 100;
constexpr byte Interval = 20;
constexpr byte InvalidSprite = 0x80;

static const word[] Chars = {
    GChar_FighterBullet + 9 * 0,
    GChar_FighterBullet + 9 * 1,
    GChar_FighterBullet + 9 * 2,
    GChar_FighterBullet + 9 * 3,
};

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
    if (x >= WindowWidth * 2) goto end;
    y = OffsetY(pBullet->y);
    if (y >= WindowHeight * 2) goto end;
    x -= HalfSize;
    y -= HalfSize;
    if (x < (WindowWidth -HalfSize) * 2 && y < (WindowHeight - HalfSize) * 2) {
        ShowSprite(pBullet->sprite, x, y, Chars[pBullet->direction & 3]);
    }
    else {
        HideSprite(pBullet->sprite);
    }
    return;
end:
    HideSprite(pBullet->sprite);
    pBullet->sprite = InvalidSprite;
}


static bool Start(byte direction) 
{
    sbyte dx, dy;
    {
        ptr<Direction> pDirection;
        direction &= 7;
        pDirection  = Directions + direction;
        dx = pDirection->dx;
        dy = pDirection->dy;
    }
    {
        byte sprite;
        ptr<FighterBullet> pBullet;
        sprite = Sprite_FighterBullet;
        for (pBullet : Bullets) {
            if (pBullet->sprite != InvalidSprite) goto next;
            Sound_Fire();
            pBullet->x = FighterX + FighterDx;
            pBullet->y = FighterY + FighterDy;
            pBullet->dx = dx;
            pBullet->dy = dy;
            pBullet->direction = direction;
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
    ptr<Enemy> pEnemy;
    if(HitEnemy(pBullet->x, pBullet->y, 0)) {
        return true;
    }
    if (HitBarrier(pBullet->x, pBullet->y, 0)) {
        return true;
    }
    if (HitFort(pBullet->x, pBullet->y, 0)) {
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
        pBullet->denominator -= pBullet->numerator;
        if (pBullet->denominator >= 0) goto locate;
       
        pBullet->x = AddX(pBullet->x, pBullet->dx);
        pBullet->y = AddY(pBullet->y, pBullet->dy);
        pBullet->denominator += 100;
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
