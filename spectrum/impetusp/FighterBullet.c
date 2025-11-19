#include "FighterBullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "Fighter.h"
#include "Sound.h"
#include "VVram.h"
#include "SkyEnemy.h"
#include "GroundEnemy.h"
#include "Barrier.h"
#include "Fort.h"

constexpr byte Size = 4;
constexpr byte InvalidY = VVramHeight * CoordRate;
constexpr byte ShortInterval = CoordRate;
constexpr byte LongInterval = ShortInterval * 4;
constexpr byte HalfMask = CoordMask >> 1;
constexpr byte Range = VVramHeight * CoordRate;

FighterBullet[MaxFighterBulletCount] FighterBullets;
static byte IntervalCount;

void InitFighterBullets()
{
    byte sprite;
    ptr<FighterBullet> pBullet;
    sprite = Sprite_FighterBullet;
    for (pBullet : FighterBullets) {
        pBullet->sprite = sprite;
        pBullet->y = InvalidY;
        ++sprite;
    }
    IntervalCount = ShortInterval;
}


static void Show(ptr<FighterBullet> pBullet)
{
    ShowSprite(pBullet, Pattern_FighterBullet);
}

static void End(ptr<FighterBullet> pBullet)
{
    pBullet->y = InvalidY;
    HideSprite(pBullet->sprite);
}


void StartFighterBullet(bool on)
{
    if (IntervalCount != 0) {
        --IntervalCount;
    }
    if (!on) {
        if (IntervalCount > ShortInterval) {
            IntervalCount = ShortInterval;
        }
        return;
    }
    if (IntervalCount != 0) return;
    {
        ptr<FighterBullet> pBullet;
        for (pBullet : FighterBullets) {
            if (pBullet->y == InvalidY) {
                Sound_Fire();
                pBullet->x = Fighter.x;
                pBullet->y = Fighter.y;
                pBullet->clock = 0;
                Show(pBullet);
                IntervalCount = LongInterval;
                return;
            }
        }
    }
}


static bool Hit(ptr<FighterBullet> pBullet)
{
    if (HitBulletSkyEnemy(pBullet->x, pBullet->y)) {
        return true;
    }
    if (HitBulletGroundEnemy(pBullet->x, pBullet->y)) {
        return true;
    }
    if (HitBulletBarrier(pBullet->x, pBullet->y)) {
        return true;
    }
    if (HitFort(pBullet->x, pBullet->y)) {
        return true;
    }
    return false;
}

void MoveFighterBullets()
{
    ptr<FighterBullet> pBullet;
    for (pBullet : FighterBullets) {
        if (pBullet->y != InvalidY) {
            --pBullet->y;
            ++pBullet->clock;
            if (
                (pBullet->clock & CoordMask / 2) == 0 && 
                (pBullet->y >= Range || Hit(pBullet))
            ) {
                End(pBullet);
            }
            else {
                Show(pBullet);
            }
            // PollVSync();
        }
    }
}
