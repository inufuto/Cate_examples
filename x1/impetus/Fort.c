#include "Fort.h"
#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Stage.h"
#include "Bang.h"
#include "Main.h"
#include "EnemyBullet.h"
#include "Math.h"
#include "Sound.h"

constexpr byte Width = 6;
constexpr byte Height = 6;
constexpr byte Left = (VVramWidth - Width) / 2;
constexpr byte FortX = Left * CoordRate;
constexpr byte MaxY = (4 + Height)* CoordRate;
constexpr byte CharCount = Width * (Height + 1);
// constexpr byte RangeY = VVramHeight * CoordRate;
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte FortY;
byte FortLife;
static byte oldY;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
}


void StartFort()
{
    FortY = 1;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
}


void DrawFort()
{
    byte y, height, c, bits;
    ptr<byte> pFront;
    
    if (FortLife == 0) return;

    c = Char_Fort;
    height = Height;
    y = (FortY >> CoordShift) - Height;
    while (y >= VVramHeight) {
        ++y;
        --height;
        c += Width;
    }
    if ((FortY & CoordMask) != 0) {
        ++height;
        c += Width * Height;
    }

    bits = 0;
    pFront = VVramFront + VVramOffset(Left, y);
    do {
        repeat(Width) {
            *pFront = c;
            ++c;
            ++pFront;
        }
        bits = (bits << 1) | 1;
        pFront += VVramWidth - Width;
        --height;
    } while (height != 0);
    if (oldY != FortY) {
        SetTRowFlags(y, bits);
    }
    oldY = FortY;
}


void EraseFort()
{
    byte height, y, bits;
    word offset;
    ptr<byte> pBack, pFront;
    
    if (FortLife == 0) return;
   
    height = Height;
    y = (oldY >> CoordShift) - Height;
    while (y >= VVramHeight) {
        ++y;
        --height;
    }
    if ((oldY & CoordMask) != 0) {
        ++height;
    }

    offset = VVramOffset(Left, y);
    pFront = VVramFront + offset;
    pBack = VVramBack + VVramWidth * TileSize + offset;
    bits = 0;
    while (height != 0) {
        repeat(Width) {
            *pFront = *pBack;
            ++pFront;
            ++pBack;
        }
        bits = (bits << 1) | 1;
        pFront += VVramWidth - Width;
        pBack += VVramWidth - Width;
        --height;
    }
    SetTRowFlags(y, bits);
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
        }
        ++localClock;
        if ((localClock & CoordMask) == 0) {
            byte y;
            y = FortY - CoordRate;
            repeat (Height / 2 - 1) {
                bulletX += CoordRate;
                if (bulletX >= FortX + Width * CoordRate) {
                    bulletX = FortX;
                }
                if (Rnd() < CurrentStage + 3) {
                    StartEnemyBullet(bulletX, y);
                }
                y -= CoordRate;
            }
        }
    }
}


bool HitFort(byte x, byte y)
{
    constexpr byte BulletSize = CoordRate;
    constexpr byte FortSize = CoordRate * Width;
    if (FortLife == 0) return;
    if (y < FortY) {
        byte bulletLeft;
        bulletLeft = x + BulletSize;
        if (
            FortX < bulletLeft + 1 &&
            bulletLeft < FortX + (FortSize + 1)
        )  {
            --FortLife;
            if (FortLife == 0) {
                Sound_LargeBang();
                StartBang(FortX + CoordRate * Width / 2, FortY - CoordRate * Height / 2, true);
                AddScore(Point);
                VVramChanged = true;
                DrawAll();
            }
            else {
                Sound_SmallBang();
                StartBang(x, y, false);
            }
            return true;
        }
    }
    return false;
}
