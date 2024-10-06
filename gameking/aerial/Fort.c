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
constexpr byte FortWidth = 6;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte RangeX = StageWidth;
constexpr byte Left = RangeX - FortWidth * 3;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;

Fort[Count] Forts;
byte FortCount;
byte FortDotOffset;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->y = InvalidY;
    }
    FortCount = 0;
    moving = false;
}


void DrawForts()
{
    static const byte[] Chars = {
        0x00, 0x02, 0xa9, 0xa5, 0xa6, 0x38, 0x00, 0xaa,
        0xaa, 0xaa, 0xaa, 0xaa, 0x00, 0x20, 0x9a, 0x5a,
        0x6a, 0x83, 0x00, 0x00, 0xf0, 0x15, 0xf0, 0x00,
        0x00, 0x2a, 0xa5, 0xa5, 0x8a, 0xc0, 0x22, 0xaa,
        0xaa, 0xaa, 0xaa, 0x88, 0x00, 0xa2, 0x5a, 0x5a,
        0xa8, 0x0c, 0x00, 0x30, 0xc1, 0x74, 0xc0, 0x00,
    };
    ptr<byte> pChars = Chars;
    if (FortDotOffset != 0) {
        pChars += FortWidth * FortHeight;
    }
    ptr<Fort> pFort;
    for (pFort: Forts) {
        byte w, added;
        ptr<byte> pVVram;
        word feed;
        if (pFort->y == InvalidY || pFort->x >= RangeX) continue;
        pVVram = VVramPtr(pFort->x, pFort->y);
        if (pFort->x > RangeX - FortWidth) {
            w = RangeX - pFort->x;
            feed = StageWidth - w;
            added = FortWidth - w;
        }
        else {
            w = FortWidth;
            feed = StageWidth - FortWidth;
            added = 0;
        }
        ptr<byte> p = pChars;
        repeat(FortHeight) {
            byte i;
            i = w;
            do {
                *pVVram = *p;
                ++pVVram;
                ++p;
                --i;
            } while (i != 0);
            pVVram += feed;
            p += added;
        }
    }
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
    FortDotOffset = 0;
    moving = true;
    BackgroundChanged = true;
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
        x = (pFort->x + 2) << CoordShift;
        y = (pFort->y + 2) << CoordShift;
        pBullet = StartEnemyBullet(x, y);
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
        BackgroundChanged = true;
        FortDotOffset = (FortDotOffset + 1) & CoordMask;
        if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                --pFort->x;
                if (pFort->x < pFort->targetX) {
                    moving = false;
                }
                Fire(pFort);
            }
            if (!moving) return;
        }
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
    xx = (x >> CoordShift) - 1;
    yy = ((y + CoordRate / 2) >> CoordShift);
    for (pFort: Forts) {
        if (pFort->y == InvalidY) continue;
        if (
            xx >= pFort->x &&
            xx < pFort->x + (FortWidth - 2) &&
            yy  >= pFort->y &&
            yy < pFort->y + (FortHeight)
        ) {
            if (--pFort->life == 0) {
                Sound_LargeBang();
                StartLargeBang(
                    (pFort->x + FortWidth / 2) << CoordShift,
                    (pFort->y + FortHeight / 2) << CoordShift
                );
                pFort->y = InvalidY;
                --FortCount;
                BackgroundChanged = true;
                AddScore(Pts);
            }
            else {
                Sound_SmallBang();
                StartSmallBang(x + CoordRate, y + CoordRate);
            }
            // Sound_Hit();
            return true;
        }
    }
    return false;
}