#include "EnemyBullet.h"
#include "Sprite.h"
#include "Chars.h"
#include "Vram.h"
#include "Math.h"
#include "Fighter.h"

constexpr byte RangeX = (WindowWidth - 1) * CoordRate;
constexpr byte RangeY = WindowHeight * CoordRate;
constexpr byte InvalidY = WindowHeight * CoordRate;

constexpr byte HiVelocity = 100;
constexpr byte LoVelocity = HiVelocity * 70 / 100; // sin 45
constexpr byte LongVelocity = HiVelocity * 92 / 100; // cos 22.5
constexpr byte ShortVelocity = HiVelocity * 38 / 100; // sin 22.5

EnemyBullet[MaxEnemyBulletCount] EnemyBullets;

void InitEnemyBullets()
{
    byte sprite;
    ptr<EnemyBullet> pBullet;
    sprite = Sprite_EnemyBullet;
    for (pBullet : EnemyBullets) {
        pBullet->sprite = sprite;
        pBullet->y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<EnemyBullet> pBullet)
{
    ShowSprite(pBullet, Pattern_EnemyBullet);
}


bool StartEnemyBullet(byte x, byte y)
{
    byte sprite;
    ptr<EnemyBullet> pBullet;

    sprite = Sprite_EnemyBullet;
    for (pBullet : EnemyBullets) {
        if (pBullet->y == InvalidY) {
            pBullet->dx = Sign(x, Fighter.x); 
            pBullet->dy = Sign(y, Fighter.y); 
            if (pBullet->dx != 0 && pBullet->dy != 0) {
                byte lx, ly;
                lx = Abs(x, Fighter.x);
                ly = Abs(y, Fighter.y);
                if (lx < ly) {
                    pBullet->numeratorX = ShortVelocity;
                    pBullet->numeratorY = LongVelocity;
                }
                else if (lx > ly) {
                    pBullet->numeratorX = LongVelocity;
                    pBullet->numeratorY = ShortVelocity;
                }
                else {
                    pBullet->numeratorX = LoVelocity;
                    pBullet->numeratorY = LoVelocity;
                }
            }
            else {
                pBullet->numeratorX = HiVelocity;
                pBullet->numeratorY = HiVelocity;
            }
            pBullet->x = x;
            pBullet->y = y;
            pBullet->clock = 0;
            pBullet->denominatorX = 0;
            pBullet->denominatorY = 0;
            Show(pBullet);
            return true;
        }
    }
    return false;
}


void MoveEnemyBullets()
{
    ptr<EnemyBullet> pBullet;
    for (pBullet : EnemyBullets) {
        if (pBullet->y != InvalidY) {
            pBullet->denominatorX -= pBullet->numeratorX;
            if (pBullet->denominatorX < 0) {
                pBullet->x += pBullet->dx;
                pBullet->denominatorX += HiVelocity;
            }
            pBullet->denominatorY -= pBullet->numeratorY;
            if (pBullet->denominatorY < 0) {
                pBullet->y += pBullet->dy;
                pBullet->denominatorY += HiVelocity;
            }
            if (
                pBullet->x >= RangeX ||
                pBullet->y >= RangeY || 
                (
                    (pBullet->clock & CoordShift) == 0 && 
                    HitBulletFighter(pBullet->x, pBullet->y)
                )
            ) {
                HideSprite(pBullet->sprite);
                pBullet->y = InvalidY;
            }
            else {
                Show(pBullet);
                ++pBullet->clock;
            }
        }
    }
}
