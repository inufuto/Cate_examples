#include "Fort.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Stage.h"
#include "Bang.h"
#include "Main.h"
#include "EnemyBullet.h"
#include "Math.h"
#include "Sound.h"

constexpr byte Width = 6;
constexpr byte Height = 6;
constexpr byte Left = (StageWidth - Width) / 2;
constexpr byte FortX = Left * CoordRate;
constexpr byte MaxY = (4 + Height) * CoordRate;
// constexpr byte CharCount = Width * (Height + 1);
constexpr byte RangeY = StageHeight * CoordRate;
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte[64 * Width * Height] FortPattern;
byte FortY;
byte FortLife;

static byte newY;
static byte oldY;

static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
    FortY = RangeY;
    oldY = StageHeight;
}

static void UpdatePosition()
{
    newY = FortY - Height * CoordRate;
}


void StartFort()
{
    FortY = 0;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
    oldY = RangeY;
    UpdatePosition();
}


void DrawFort()
{
    if (FortLife != 0) {
        DrawFortPattern(FortX, newY);
    }
    oldY = newY;
}


void EraseFort()
{
    if (oldY >= 0x80 || oldY < RangeY) {
        byte y, height;
        height = Height * CoordRate;
        y = oldY;
        while (y >= 0x80) {
            --height;
            ++y;
        }
        height >>= CoordShift;
        if ((y & CoordMask) != 0) {
            ++height;
        }
        y >>= CoordShift;
        while (height > 0) {
            EraseBackupH(FortX >> CoordShift, y, Width);
            ++y;
            --height;
        }
    }
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            UpdatePosition();
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
    if (FortLife == 0) return false;
    x += CoordRate - 1;
    if (
        x >= FortX && x < FortX + Width * CoordRate && y < FortY
    )  {
        --FortLife;
        if (FortLife == 0) {
            Sound_LargeBang();
            StartBang(FortX + CoordRate * Width / 2, FortY - CoordRate * Height / 2, true);
            AddScore(Point);
            FortY = RangeY;
            UpdatePosition();
            // GroundChanged = true;
            // DrawAll();
        }
        else {
            Sound_SmallBang();
            StartBang(x, y, false);
        }
        // Sound_Hit();
        return true;
    }
    return false;
}
