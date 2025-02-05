#include "Bullet.h"
#include "Sprite.h"
#include "Stage.h"

constexpr byte InvalidY = 0xff;
constexpr byte RangeX = (StageWidth - 1) * BulletRate;
constexpr byte RangeY = (StageHeight - 1) * BulletRate;


void EndBullet(ptr<Bullet> pBullet)
{
    pBullet->_.y = InvalidY;
    HideSprite(pBullet->_.sprite);
}


void StartBullet(ptr<Bullet> pBullet, byte x, byte y)
{
    pBullet->_.x = x;
    pBullet->_.y = y;
    pBullet->_.clock = 0;
    pBullet->denominatorX = 0;
    pBullet->denominatorY = 0;
}


bool MoveBullet(ptr<Bullet> pBullet)
{
    pBullet->denominatorX -= pBullet->numeratorX;
    while (pBullet->denominatorX < 0) {
        pBullet->_.x += pBullet->dx;
        pBullet->denominatorX += HiVelocity;
    }
    pBullet->denominatorY -= pBullet->numeratorY;
    while (pBullet->denominatorY < 0) {
        pBullet->_.y += pBullet->dy;
        pBullet->denominatorY += HiVelocity;
    }
    if (
        pBullet->_.x >= RangeX || 
        pBullet->_.y  >> BulletShift >= GroundY(pBullet->_.x >> BulletShift)
    ) {
        return false;
    }
    return true;
}
