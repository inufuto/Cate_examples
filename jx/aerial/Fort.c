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
constexpr byte FortWidth = 8;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 0;
constexpr byte RangeX = StageWidth;
constexpr byte Left = 12;   //VramWidth - 20;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;

byte[64 * FortWidth * FortHeight + 4] FortPattern;
Fort[Count] Forts;
byte FortCount;
byte FortDotOffset;
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
    FortDotOffset = 0;
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
        FortDotOffset = (FortDotOffset + 1) & CoordMask;
        if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                --pFort->x;
                if (pFort->x <= pFort->targetX) {
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
            // Sound_Hit();
            return true;
        }
    }
    return false;
}


void DrawForts()
{
	static const byte[] Chars = {
//
		Char_Space, Char_Fort + 0, Char_Fort + 1, Char_Fort + 2, Char_Fort + 3, Char_Fort + 4, Char_Fort + 5, Char_Fort + 6, 
		Char_Space, Char_Fort + 7, Char_Fort + 8, Char_Fort + 9, Char_Fort + 10, Char_Fort + 11, Char_Fort + 12, Char_Fort + 13, 
		Char_Space, Char_Space, Char_Fort + 14, Char_Fort + 15, Char_Fort + 16, Char_Fort + 17, Char_Fort + 18, Char_Fort + 19, 
		Char_Space, Char_Fort + 20, Char_Fort + 21, Char_Fort + 22, Char_Fort + 23, Char_Fort + 24, Char_Fort + 25, Char_Space, 
//
		Char_Fort + 26, Char_Fort + 27, Char_Fort + 28, Char_Fort + 29, Char_Fort + 30, Char_Fort + 31, Char_Fort + 32, Char_Fort + 33, 
		Char_Fort + 34, Char_Fort + 35, Char_Fort + 36, Char_Fort + 37, Char_Fort + 38, Char_Fort + 39, Char_Fort + 40, Char_Fort + 41, 
		Char_Space, Char_Fort + 42, Char_Fort + 43, Char_Fort + 44, Char_Fort + 45, Char_Fort + 46, Char_Fort + 47, Char_Fort + 48, 
		Char_Space, Char_Fort + 49, Char_Fort + 50, Char_Fort + 51, Char_Fort + 52, Char_Fort + 53, Char_Space, Char_Space, 
	};
    ptr<Fort> pFort;
    for (pFort: Forts) {
        byte y;
        y = pFort->y;
        if (y != InvalidY) {
            byte x, width;
            x = pFort->x;
            width = RangeX - x;
            if (x < RangeX && width > 0) {
                if (width > FortWidth) {
                    width = FortWidth;
                }
                ptr<byte> pRow = VVramPtr(x, y);
                ptr<byte> pChars = Chars + (FortDotOffset << 5);
                repeat(FortHeight) {
                    ptr<byte> pVVram = pRow;
                    ptr<byte> p = pChars;
                    byte i;
                    for (i = 0; i < width; ++i) {
                        *pVVram = *p;
                        ++pVVram;
                        ++p;
                    }
                    pRow += VVramWidth;
                    pChars += FortWidth;
                }
            }
        }
        pFort->oldX = pFort->x;
        pFort->oldY = pFort->y;
    }
}
