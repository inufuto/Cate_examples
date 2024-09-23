#include "EnemyBullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "MyFighter.h"


constexpr byte Count = Sprite_Bang - Sprite_EnemyBullet;
constexpr byte InvalidY = 0xff;


Bullet[Count] EnemyBullets;

void InitEnemyBullets()
{
    byte sprite;
    ptr<Bullet> pBullet;
    sprite = Sprite_EnemyBullet;
    for (pBullet : EnemyBullets) {
        pBullet->_.sprite = sprite;
        pBullet->_.y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<Bullet> pBullet)
{
    ShowSprite(
        &pBullet->_, 
        Char_EnemyBullet + (pBullet->_.x & 1) + ((pBullet->_.y & 1) << 1)        
    );
}


ptr<Bullet> StartEnemyBullet(byte x, byte y)
{
    ptr<Bullet> pBullet;
    for (pBullet : EnemyBullets) {
        if (pBullet->_.y != InvalidY) continue;
        StartBullet(pBullet, x, y);
        Show(pBullet);
        return pBullet;
    }
    return nullptr;
}


void MoveEnemyBullets()
{
    ptr<Bullet> pBullet;
    for (pBullet : EnemyBullets) {
        if (pBullet->_.y == InvalidY) continue;
        if (
            MoveBullet(pBullet) &&
            !(
                (pBullet->_.clock & BulletMask) == 0 &&
                HitBulletMyFighter(pBullet->_.x, pBullet->_.y)
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