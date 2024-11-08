#include "Fort.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
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
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte FortY, oldFortY0, oldFortY1;
byte FortLife;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
    FortY = 0;
    oldFortY0 = 0;
    oldFortY1 = 0;
}


void StartFort()
{
    FortY = 1;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            if ((FortY & CoordMask) == 0) {
                VVramChanged = true;
            }
            // SetFortPattern();
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
            // Sound_LargeBang();
            StartBang(FortX + CoordRate * Width / 2, FortY - CoordRate * Height / 2, true);
            FortY = 0;
            AddScore(Point);
            // VVramChanged = true;
        }
        else {
            // Sound_SmallBang();
            StartBang(x, y, false);
        }
        Sound_Hit();
        return true;
    }
    return false;
}
