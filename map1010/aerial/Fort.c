#include "Fort.h"
#include "Chars.h"
#include "VVram.h"
#include "Main.h"
#include "Stage.h"
#include "Movable.h"
#include "Sound.h"
#include "Bang.h"
#include "Math.h"
#include "EnemyBullet.h"
#include "MyFighter.h"

constexpr byte Count = 6;
constexpr byte FortWidth = 7;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 2;
constexpr byte RangeX = VramWidth;
constexpr byte Left = 12;   //VramWidth - 20;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (1 << 2) - 1;

Fort[Count] Forts;
byte FortCount;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->y = InvalidY;
        pFort->oldY = InvalidY;
    }
    FortCount = 0;
    moving = false;
}


void DrawForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        byte w, c, added;
        ptr<byte> pFront;
        word feed;
        if (pFort->y == InvalidY || pFort->x >= RangeX) goto next;
        pFront = VVramFront + VVramOffset(pFort->x, pFort->y);
        if (pFort->x > RangeX - FortWidth) {
            w = RangeX - pFort->x;
            feed = VVramWidth - w;
            added = FortWidth - w;
        }
        else {
            w = FortWidth;
            feed = VVramWidth - FortWidth;
            added = 0;
        }
        c = Char_Fort;
        repeat(FortHeight) {
            byte i;
            i = w;
            do {
                *pFront = c;
                ++pFront;
                ++c;
                --i;
            } while (i != 0);
            pFront += feed;
            c += added;
        }
        SetRowFlags(pFort->y, 0x0f);
        next:
        pFort->oldX = pFort->x;
        pFort->oldY = pFort->y;
    }
}


void EraseForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        byte w;
        word offset, feed;
        ptr<byte> pFront, pBack;
        if (pFort->oldY == InvalidY || pFort->oldX >= RangeX) continue;
        offset = VVramOffset(pFort->oldX, pFort->oldY);
        pFront = VVramFront + offset;
        pBack = VVramBack + offset;
        if (pFort->oldX > RangeX - FortWidth) {
            w = RangeX - pFort->oldX;
            feed = VVramWidth - w;
        }
        else {
            w = FortWidth;
            feed = VVramWidth - FortWidth;
        }
        repeat(FortHeight) {
            byte i;
            i = w;
            do {
                *pFront = *pBack;
                ++pFront;
                ++pBack;
                --i;
            } while (i != 0);
            pFront += feed;
            pBack += feed;
        }
        SetRowFlags(pFort->oldY, 0x0f);
    }
}


static void End(ptr<Fort> pFort)
{
    pFort->y = InvalidY;
    --FortCount;
}


void StartForts()
{
    byte i, x, y;
    ptr<Fort> pFort;
    FortCount = 0;
    i = (CurrentStage + 2) >> 1;
    if (i > Count) {
        i = Count;
    }
    pFort = Forts;
    x = RangeX;
    y = 0;
    do {
        byte targetX;
        targetX = x - (RangeX - Left);
        if (targetX >= RangeX - FortWidth) break;
        pFort->x = x;
        pFort->targetX = targetX;
        pFort->y = y;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++FortCount;
        ++pFort;
        y += FortHeight * 3 / 2;
        if (y + FortHeight > MinGroundY) {
            x += FortWidth * 4 / 3;
            y = 0;
        }
        --i;
    } while (i != 0);
    moving = true;
}


static void Fire(ptr<Fort> pFort)
{
    if (
        (pFort->clock & FireMask) == 0 &&
        pFort->x < (RangeX - 2) //&&
        //Rnd() < CurrentStage + 4
    ) {
        byte x, y;
        ptr<Bullet> pBullet;
        x = (pFort->x + 2);
        y = (pFort->y + 2);
        pBullet = StartEnemyBullet(x << BulletShift, y << BulletShift);
        if (pBullet != nullptr) {
            pBullet->dx = -1;
            pBullet->dy = Sign(y, MyFighter.y);
            if (pBullet->dy != 0) {
                byte lx, ly;
                lx = Abs(x, MyFighter.x);
                ly = Abs(y, MyFighter.y);
                if (lx < ly) {
                    pBullet->numeratorX = ShortVelocity * 4 / 3;
                    pBullet->numeratorY = LongVelocity * 4 / 3;
                }
                else if (lx > ly) {
                    pBullet->numeratorX = LongVelocity * 4 / 3;
                    pBullet->numeratorY = ShortVelocity * 4 / 3;
                }
                else {
                    pBullet->numeratorX = LoVelocity * 4 / 3;
                    pBullet->numeratorY = LoVelocity * 4 / 3;
                }
            }
            else {
                pBullet->numeratorX = HiVelocity * 4 / 3;
                pBullet->numeratorY = HiVelocity * 4 / 3;
            }
        }
    }
}


void MoveForts()
{
    if (moving) {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->y == InvalidY) continue;
            if (pFort->x > pFort->targetX) {
                --pFort->x;
            }
            else {
                moving = false;
            }
            Fire(pFort);
        }
        if (!moving) return;
    }
    else {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->y == InvalidY) continue;
            Fire(pFort);
            ++pFort->clock;
        }
    }
}


bool HitBulletFort(byte x, byte y)
{
    ptr<Fort> pFort;
    byte xx, yy;
    xx = (x >> BulletShift) - 1;
    yy = ((y + BulletRate / 2) >> BulletShift);
    for (pFort: Forts) {
        if (pFort->y == InvalidY) continue;
        if (
            xx >= pFort->x &&
            xx < pFort->x + (FortWidth - 2) &&
            yy  >= pFort->y &&
            yy < pFort->y + (FortHeight)
        ) {
            if (--pFort->life ==0) {
                Sound_LargeBang();
                StartLargeBang(
                    (pFort->x + FortWidth / 2),
                    (pFort->y + FortHeight / 2)
                );
                End(pFort);
                AddScore(Pts);
            }
            else {
                Sound_SmallBang();
                StartSmallBang((x >> BulletShift) + 1, (y >> BulletShift) + 1);
            }
            return true;
        }
    }
    return false;
}