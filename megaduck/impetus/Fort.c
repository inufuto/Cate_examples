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

constexpr byte Left = (WindowWidth - FortWidth) / 2;
constexpr byte FortX = Left * CoordRate;
constexpr byte MaxY = (4 + FortHeight)* CoordRate;
// constexpr byte RangeY = WindowWidth * CoordRate;
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte FortY;
byte FortLife;
byte FortCharOffset;
bool FortChanged;
static byte oldY;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
    FortChanged = false;
}


void StartFort()
{
    FortCharOffset = 0;
    FortY = 1;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
    BackgroundChanged = true;
}


void DrawFort(word vram)
{
    if (FortLife == 0) return;

    byte c = Char_Fort + FortCharOffset;
    byte height = FortHeight;
    byte y = (FortY >> CoordShift) - FortHeight;
    while (y >= WindowWidth) {
        ++y;
        --height;
        c += FortWidth;
    }
    if ((FortY & CoordMask) != 0) {
        ++height;
    }

    oldY = y;
    vram += VramOffset(Left, y);
    do {
        repeat(FortWidth) {
            vram = WriteVram(vram, c);
            ++c;
        }
        vram += VramRowSize - FortWidth * VramStep;
        --height;
        ++y;
    } while (height != 0);
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            FortCharOffset ^= FortCharCount;
            SetFortPattern();
            if ((FortY & CoordMask) == 0) {
                BackgroundChanged = true;
            }
            else {
                FortChanged = true;
            }
        }
        ++localClock;
        if ((localClock & CoordMask) == 0) {
            byte y = FortY - CoordRate;
            repeat (FortHeight / 2 - 1) {
                bulletX += CoordRate;
                if (bulletX >= FortX + FortWidth * CoordRate) {
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
        x >= FortX && x < FortX + FortWidth * CoordRate && y < FortY
    )  {
        --FortLife;
        if (FortLife == 0) {
            Sound_LargeBang();
            StartBang(FortX + CoordRate * FortWidth / 2, FortY - CoordRate * FortHeight / 2, true);
            AddScore(Point);
            BackgroundChanged = true;
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
