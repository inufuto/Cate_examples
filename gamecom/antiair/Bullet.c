#include "Bullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Sound.h"
#include "Cannon.h"
#include "Ufo.h"
#include "Block.h"

constexpr byte InvalidY = 0xff;
constexpr byte Interval = 9 * CoordRate;
constexpr byte Range = WindowHeight * CoordRate;

Movable[MaxBulletCount] Bullets;
static byte IntervalCount;
static byte BulletCount;

void InitBullets()
{
    byte sprite;
    ptr<Movable> pBullet;
    sprite = Sprite_Bullet;
    for (pBullet : Bullets) {
        pBullet->sprite = sprite;
        pBullet->y = InvalidY;
        HideSprite(sprite);
        ++sprite;
    }
    IntervalCount = 0;
    BulletCount = 0;
}

static void Show(ptr<Movable> pBullet)
{
    ShowSprite(pBullet, Pattern_Bullet);
}

static void End(ptr<Movable> pBullet)
{
    pBullet->y = InvalidY;
    HideSprite(pBullet->sprite);
    --BulletCount;
}

bool CanFire()
{
    return IntervalCount == 0 && BulletCount < MaxBulletCount;
}

void StartBullet()
{
    ptr<Movable> pBullet;
    if (IntervalCount != 0) return;
    for (pBullet : Bullets) {
        if (pBullet->y < Range) continue;
        Sound_Fire();
        pBullet->x = Cannon.x;
        pBullet->y = Cannon.y;
        Show(pBullet);
        IntervalCount = Interval;
        ++BulletCount;
        return;
    }
}

static bool Hit(ptr<Movable> pBullet)
{
    if (HitUfo(pBullet->x, pBullet->y)) {
        return true;
    }
    if (HitBlock(pBullet->x, pBullet->y)) {
        return true;
    }
    return false;
}


void MoveBullets()
{
    ptr<Movable> pBullet;
    for (pBullet : Bullets) {
        if (pBullet->y >= Range) continue;
        --pBullet->y;
        if (
            pBullet->y >= Range || 
            ((pBullet->y & CoordMask) == 0 && Hit(pBullet))
        ) {
            End(pBullet);
        }
        else {
            Show(pBullet);
        }
    }
    if (IntervalCount != 0) {
        --IntervalCount;
        return;
    }
}
