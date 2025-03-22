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
#include "Sprite.h"

constexpr byte Count = 6;
constexpr byte FortWidth = 8;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 2;
constexpr byte RangeX = StageWidth + 1;
constexpr byte Left = 10;   //VramWidth - 20;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;

Fort[Count] Forts;
byte FortCount;
byte FortDotOffset;
static bool moving;

void InitForts()
{
    byte sprite = Sprite_Fort;
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->y = InvalidY;
        pFort->sprite = sprite;
        sprite += FortWidth / 2 * 2;
    }
    FortCount = 0;
    moving = false;
}


static void Draw(ptr<Fort> pFort)
{
    byte x = pFort->x;
    if (x >= RangeX) return;
    byte xd = (x << CoordShift) - FortDotOffset;
    byte yd = pFort->y << CoordShift;
    byte sprite = pFort->sprite;
    byte pattern = Pattern_Fort;

    repeat (FortWidth / 2) {
        if (x < RangeX) {
            ShowSpriteXY(sprite, xd, yd, pattern);
            ShowSpriteXY(sprite + FortWidth / 2, xd, yd + 16, pattern + FortWidth / 2);
        }
        x += 2;
        xd += 16;
        ++pattern;
        ++sprite;
    }
}


static void End(ptr<Fort> pFort)
{
    byte sprite = pFort->sprite;
    repeat (FortWidth / 2 * FortHeight / 2) {
        HideSprite(sprite);
        ++sprite;
    }
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
    FortDotOffset = 0;
    // FortCharOffset = 0;
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
        if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                if (pFort->x > pFort->targetX) {
                    --pFort->x;
                    Draw(pFort);
                }
                else {
                    moving = false;
                }
                Fire(pFort);
            }
        }
        else {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                Draw(pFort);
            }
        }
        FortDotOffset = (FortDotOffset + 1) & 7;
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
            if (--pFort->life ==0) {
                Sound_LargeBang();
                StartLargeBang(
                    (pFort->x + FortWidth / 2) << CoordShift,
                    (pFort->y + FortHeight / 2) << CoordShift
                );
                End(pFort);
                AddScore(Pts);
            }
            else {
                Sound_SmallBang();
                StartSmallBang(x + CoordRate, y + CoordRate);
            }
            return true;
        }
    }
    return false;
}