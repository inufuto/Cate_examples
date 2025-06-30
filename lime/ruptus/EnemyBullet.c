#include "EnemyBullet.h"
#include "Sprite.h"
#include "Enemy.h"
#include "Stage.h"
#include "VVram.h"
#include "Chars.h"
#include "Direction.h"
#include "Fighter.h"
#include "Barrier.h"
#include "Fort.h"
#include "Main.h"

constexpr byte MaxCount = 4;
constexpr byte SpriteColor = 10;
constexpr byte HiVelocity = 28;
constexpr byte LoVelocity = HiVelocity * 70 / 100;
constexpr byte LongVelocity = HiVelocity * 92 / 100;
constexpr byte ShortVelocity = HiVelocity * 38 / 100;
constexpr byte InvalidSprite = 0x80;

// constexpr byte Code_Up = Char_EnemyBullet + 1;
// constexpr byte Code_UpRight = Char_EnemyBullet + 1;
// constexpr byte Code_Right = Char_EnemyBullet + 3;
// constexpr byte Code_DownRight = Char_EnemyBullet + 3;
// constexpr byte Code_Down = Char_EnemyBullet + 3;
// constexpr byte Code_DownLeft = Char_EnemyBullet + 2;
// constexpr byte Code_Left = Char_EnemyBullet + 2;
// constexpr byte Code_UpLeft = Char_EnemyBullet + 0;


static EnemyBullet[MaxCount] Bullets;

void InitEnemyBullets() 
{
    ptr<EnemyBullet> pBullet;
    for (pBullet : Bullets) {
        pBullet->sprite = InvalidSprite;
    }
}


static bool Locate(ptr<EnemyBullet> pBullet)
{
    byte x, y;

    x = OffsetX(pBullet->x);
    if (x >= VVramWidth) goto end;
    y = OffsetY(pBullet->y);
    if (y >= VVramHeight) goto end;

    ShowSprite(pBullet->sprite, x, y, Pattern_EnemyBullet);
    return true;
end:
    HideSprite(pBullet->sprite);
    pBullet->sprite = InvalidSprite;
    return false;
}


bool StartEnemyBullet(ptr<Enemy> pEnemy)
{
    byte sprite;
    ptr<EnemyBullet> pBullet;

    sprite = Sprite_EnemyBullet;
    for (pBullet : Bullets) {
        byte rnd;
        ptr<Direction> pEnemyDirection;
        sbyte enemyDx, enemyDy;

        if (pBullet->sprite != InvalidSprite) goto next;

        rnd = Rnd() & 3;
        if (rnd == 3) rnd = 0;
        pEnemyDirection = Directions + pEnemy->direction;
        enemyDx = pEnemyDirection->dx;
        enemyDy = pEnemyDirection->dy;
        if (enemyDx != 0) {
            if (enemyDy != 0) {
                pBullet->dx = enemyDx; 
                pBullet->dy = enemyDy;
                if (rnd == 1) {
                    pBullet->numeratorX = ShortVelocity;
                    pBullet->numeratorY = LongVelocity;
                }
                else if (rnd == 2) {
                    pBullet->numeratorX = LongVelocity;
                    pBullet->numeratorY = ShortVelocity;
                }
                else {
                    pBullet->numeratorX = LoVelocity;
                    pBullet->numeratorY = LoVelocity;
                }
            }
            else {
                pBullet->dx = enemyDx; 
                if (rnd == 1) {
                    pBullet->numeratorX = LongVelocity;
                    pBullet->numeratorY = ShortVelocity;
                    pBullet->dy = -1;
                }
                else if (rnd == 2) {
                    pBullet->numeratorX = LongVelocity;
                    pBullet->numeratorY = ShortVelocity;
                    pBullet->dy = 1;
                }
                else {
                    pBullet->numeratorX = HiVelocity;
                    pBullet->numeratorY = HiVelocity;
                    pBullet->dy = 0;
                }
            }
        }
        else {
            pBullet->dy = enemyDy; 
            if (rnd == 1) {
                pBullet->numeratorX = ShortVelocity;
                pBullet->numeratorY = LongVelocity;
                pBullet->dx = -1;
            }
            else if (rnd == 2) {
                pBullet->numeratorX = ShortVelocity;
                pBullet->numeratorY = LongVelocity;
                pBullet->dx = 1;
            }
            else {
                pBullet->numeratorX = HiVelocity;
                pBullet->numeratorY = HiVelocity;
                pBullet->dx = 0;
            }
        }
        pBullet->x = pEnemy->x + enemyDx;
        pBullet->y = pEnemy->y + enemyDy;
        pBullet->sprite = sprite;
        pBullet->denominatorX = 0;
        pBullet->denominatorY = 0;
        return Locate(pBullet);
    next:
        ++sprite;
    }
    return false;
}

static bool Hit(ptr<EnemyBullet> pBullet)
{
    ptr<Enemy> pEnemy;
    if (HitFighter(pBullet->x, pBullet->y, 0)) {
        return true;
    }
    // if (HitBarrier(pBullet->x, pBullet->y, 0)) {
    //     return true;
    // }
    // if (HitFort(pBullet->x, pBullet->y, 0)) {
    //     return true;
    // }
    return false;
}


void MoveEnemyBullets()
{
    ptr<EnemyBullet> pBullet;
    for (pBullet : Bullets) {
        sbyte dx, dy;
        byte direction;
        ptr<Direction> pDirection;

        if (pBullet->sprite == InvalidSprite) continue;

        if ((Clock & 1) == 0) {
            pBullet->denominatorX -= pBullet->numeratorX;
            if (pBullet->denominatorX < 0) {
                pBullet->x = AddX(pBullet->x, pBullet->dx);
                pBullet->denominatorX += 100;
            }
            pBullet->denominatorY -= pBullet->numeratorY;
            if (pBullet->denominatorY < 0) {
                pBullet->y = AddY(pBullet->y, pBullet->dy);
                pBullet->denominatorY += 100;
            }
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
