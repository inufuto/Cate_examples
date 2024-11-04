#include "Fort.h"
#include "Chars.h"
#include "Vram.h"
#include "Main.h"
#include "Stage.h"
#include "Movable.h"
#include "Sound.h"
#include "Bang.h"
#include "Math.h"
#include "EnemyBullet.h"
#include "MyFighter.h"

constexpr byte Count = 6;
constexpr byte FortWidth = 8;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 2;
constexpr byte RangeX = StageWidth;
constexpr byte Left = 5;//RangeX - FortWidth * 3;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;
constexpr word Char_Fort = 0x100;

struct Position {
    byte x, y;
};
struct Fort {
    Position position;
    Position oldPosition0;
    Position oldPosition1;
    byte targetX;
    byte life;
    byte clock;
};

Fort[Count] Forts;
byte FortCount;
byte FortOffset;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->position.y = InvalidY;
        pFort->oldPosition0.y = InvalidY;
        pFort->oldPosition1.y = InvalidY;
    }
    FortCount = 0;
    moving = false;
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
        pFort->position.x = x;
        pFort->targetX = targetX;
        pFort->position.y = y;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++FortCount;
        ++pFort;
        y += FortHeight + 1;
        if (y + FortHeight > MinGroundY) {
            x += FortWidth;
            y = 0;
        }
        --i;
    } while (i != 0);
    FortOffset = 0;
    moving = true;
    // BackgroundChanged = true;
}


static void Fire(ptr<Fort> pFort)
{
    if (
        (pFort->clock & FireMask) == 0 &&
        pFort->position.x < (RangeX - 2) //&&
        //Rnd() < CurrentStage + 4
    ) {
        byte x, y;
        ptr<Bullet> pBullet;
        x = (pFort->position.x + 2) << CoordShift;
        y = (pFort->position.y + 2) << CoordShift;
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
        // BackgroundChanged = true;
        FortOffset = (FortOffset + 1) & CoordMask;
        if (FortOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->position.y == InvalidY) continue;
                --pFort->position.x;
                if (pFort->position.x < pFort->targetX) {
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
            if (pFort->position.y == InvalidY) continue;
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
        if (pFort->position.y == InvalidY) continue;
        if (
            xx >= pFort->position.x &&
            xx < pFort->position.x + (FortWidth - 2) &&
            yy  >= pFort->position.y &&
            yy < pFort->position.y + (FortHeight)
        ) {
            if (--pFort->life == 0) {
                // Sound_LargeBang();
                StartLargeBang(
                    (pFort->position.x + FortWidth / 2) << CoordShift,
                    (pFort->position.y + FortHeight / 2) << CoordShift
                );
                pFort->position.y = InvalidY;
                --FortCount;
                // BackgroundChanged = true;
                AddScore(Pts);
            }
            else {
                // Sound_SmallBang();
                StartSmallBang(x + CoordRate, y + CoordRate);
            }
            Sound_Hit();
            return true;
        }
    }
    return false;
}


void DrawForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->position.y != InvalidY && pFort->position.x < RangeX) {
            DrawFort(pFort->position.x, pFort->position.y);
        }
        pFort->oldPosition0.x = pFort->position.x;
        pFort->oldPosition0.y = pFort->position.y;
    }
}


void EraseForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->oldPosition1.y != InvalidY && pFort->oldPosition1.x < RangeX) {
            EraseFort(pFort->oldPosition1.x, pFort->oldPosition1.y);
        }
        pFort->oldPosition1.x = pFort->oldPosition0.x;
        pFort->oldPosition1.y = pFort->oldPosition0.y;
        // pFort->oldPosition0.x = pFort->position.x;
        // pFort->oldPosition0.y = pFort->position.y;
    }
}
