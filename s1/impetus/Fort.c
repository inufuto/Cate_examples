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
constexpr byte MaxY = (4 + Height)* CoordRate;
constexpr byte CharCount = Width * (Height + 1);
constexpr byte MaxLife = 10;
constexpr word Point = 50;
constexpr byte InvalidY = StageHeight;

byte FortY;
byte FortLife;
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
    BackgroundChanged = true;
}


void DrawFort()
{
    if (FortLife == 0) return;
    byte height;
    byte c;
    if ((FortY & 1) == 0) {
        c = Char_Fort0;
        height = Height;
    }
    else {
        c = Char_Fort1;
        height = Height + 1;
    }
    byte y = (FortY >> CoordShift) - Height;
    while (y >= StageHeight) {
        ++y;
        --height;
        c += Width;
    }
    word vram = NextPage() + VramOffset(Left, y);
    do {
        repeat(Width) {
            vram = WriteTVram(vram, c);
            ++c;
        }
        vram += VramRowSize - Width * VramStep;
        --height;
    } while (height != 0);
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            BackgroundChanged = true;
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
            // GroundChanged = true;
            DrawAll();
        }
        else {
            Sound_SmallBang();
            StartBang(x, y, false);
        }
        BackgroundChanged = true;
        return true;
    }
    return false;
}
