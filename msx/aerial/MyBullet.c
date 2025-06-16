#include "MyBullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "Sound.h"
#include "MyFighter.h"
#include "EnemyFighter.h"
#include "GroundEnemy.h"
#include "Fort.h"

constexpr byte Color = 15;
constexpr byte Count = Sprite_EnemyBullet - Sprite_MyBullet;
constexpr byte InvalidY = 0xff;
constexpr byte ShortInterval = CoordRate;
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
    ShowSprite(&pBullet->_, Pattern_Bullet, Color);
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
            StartBullet(pBullet, MyFighter.x + CoordRate, MyFighter.y + CoordRate);
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
                (pBullet->_.clock & (CoordMask / 2)) == 0 &&
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
    constexpr byte Range = CoordRate / 2;
    return
        x + Range >= pMovable->x &&
        x < pMovable->x + (CoordRate + Range) &&
        y + Range >= pMovable->y &&
        y < pMovable->y + (CoordRate + Range);
}
