#include "MyBullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "Sound.h"
#include "MyFighter.h"
#include "EnemyFighter.h"
#include "GroundEnemy.h"
#include "Fort.h"


constexpr byte Count = Sprite_EnemyBullet - Sprite_MyBullet;
constexpr byte InvalidY = 0xff;
constexpr byte ShortInterval = 2;
constexpr byte LongInterval = ShortInterval * 4;

Bullet[Count] MyBullets;
static byte intervalCount;


void InitMyBullets()
{
    byte sprite;
    ptr<Bullet> pBullet;
    sprite = Sprite_MyBullet;
    for (pBullet : MyBullets) {
        pBullet->_.sprite = sprite;
        pBullet->_.y = InvalidY;
        ++sprite;
    }
    intervalCount = ShortInterval;
}


static void Show(ptr<Bullet> pBullet)
{
    ShowSprite(
        &pBullet->_, 
        Char_MyBuulet + (pBullet->_.x & 1) + ((pBullet->_.y & 1) << 1)
    );
}



void StartMyBullet(bool on)
{
    if (intervalCount != 0) {
        --intervalCount;
    }
    if (!on) {
        if (intervalCount > ShortInterval) {
            intervalCount = ShortInterval;
        }
        return;
    }
    if (intervalCount != 0) return;
    {
        ptr<Bullet> pBullet;
        for (pBullet : MyBullets) {
            if (pBullet->_.y != InvalidY) continue;
            Sound_Fire();
            StartBullet(
                pBullet, 
                (MyFighter.x + 1) << BulletShift, 
                (MyFighter.y + 1) << BulletShift
            );
            pBullet->dx = 1;
            pBullet->dy = MyFighterDy;
            if (MyFighterDy != 0) {
                pBullet->numeratorX = LoVelocity * 4 / 3;
                pBullet->numeratorY = LoVelocity * 4 / 3;
            }
            else {
                pBullet->numeratorX = HiVelocity * 4 / 3;
                pBullet->numeratorY = HiVelocity * 4 / 3;
            }
            Show(pBullet);
            intervalCount = LongInterval;
            return;
        }
    }
}


static bool Hit(byte x, byte y)
{
    return
        HitBulletEnemyFighter(x, y) || HitBulletGroundEnemy(x, y) || HitBulletFort(x, y);
}

void MoveMyBullets()
{
    ptr<Bullet> pBullet;
    for (pBullet : MyBullets) {
        if (pBullet->_.y == InvalidY) continue;
        // if (HitEnemy(pBullet->x, pBullet->y, 0)) {
        //     goto end;
        // }
        if (
            MoveBullet(pBullet) &&
            !(
                (pBullet->_.clock & (BulletMask / 2)) == 0 &&
                Hit(pBullet->_.x, pBullet->_.y)
            )
        ) {
            Show(pBullet);
            ++pBullet->_.clock;
        }
        else {
            EndBullet(pBullet);
        }
    }
}


bool HitMyBullet(ptr<Movable> pMovable, byte x, byte y) 
{
    byte xx, yy;
    xx = pMovable->x << BulletShift;
    yy = pMovable->y << BulletShift;
    return
        x >= xx && x < xx + 2 * BulletRate &&
        y >= yy && y < yy + 2 * BulletRate;
}
