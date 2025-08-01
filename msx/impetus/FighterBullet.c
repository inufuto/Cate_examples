#include "FighterBullet.h"
#include "Stage.h"
#include "Sprite.h"
#include "Fighter.h"
#include "Vram.h"
#include "SkyEnemy.h"
#include "GroundEnemy.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sound.h"

constexpr byte Size = 4;
constexpr byte Color = 15;
constexpr byte Count = Sprite_EnemyBullet - Sprite_FighterBullet;
constexpr byte Range = VramHeight * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte ShortInterval = CoordRate;
constexpr byte LongInterval = ShortInterval * 4;
constexpr byte HalfMask = CoordMask >> 1;

FighterBullet[Count] FighterBullets;
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
    ShowSprite(pBullet->sprite, pBullet->x, pBullet->y, Pattern_FighterBullet, Color);
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
            if (pBullet->y < Range) continue;
            Sound_Fire();
            pBullet->x = FighterX;
            pBullet->y = FighterY;
            pBullet->clock = 0;
            Show(pBullet);
            IntervalCount = LongInterval;
            return;
        }
    }
}


static bool Hit(ptr<FighterBullet> pBullet)
{
    if ((pBullet->y & HalfMask) != 0) return false;

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
        if (pBullet->y >= Range) continue;
        // if (HitEnemy(pBullet->x, pBullet->y, 0)) {
        //     goto end;
        // }
        --pBullet->y;
        if (
            pBullet->y >= Range || 
            ((pBullet->clock & CoordMask) == 0 && Hit(pBullet))
        ) {
            End(pBullet);
        }
        else {
            Show(pBullet);
        }
    }
}
