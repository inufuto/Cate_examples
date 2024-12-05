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
#include "Vram.h"

extern void _deb();

constexpr byte Width = 6;
constexpr byte Height = 6;
constexpr byte Left = (VVramWidth - Width) / 2;
constexpr byte FortX = Left * CoordRate;
constexpr byte MaxY = (4 + Height) * CoordRate;
constexpr byte CharCount = Width * (Height + 1);
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte FortY;
byte FortLife;
byte FortCharOffset;
static byte oldY;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
    FortY = 0;
    FortCharOffset = 0;
}


void StartFort()
{
    FortY = 1;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
    // Show();
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            MakeFortPattern();
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
            // Sound_LargeBang();
            StartBang(FortX + CoordRate * Width / 2, FortY - CoordRate * Height / 2, true);
            AddScore(Point);
            FortY = 0;
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


void DrawFort()
{
    if (FortLife != 0) {
        byte y = (FortY >> CoordShift) - Height;
        byte height = Height;
        if ((FortY & CoordMask) != 0) {
            ++height;
        }
        ptr<byte> pVVram = VVramPtr(Left, y + Height) - VVramWidth * Height;
        byte c = Char_Fort + FortCharOffset;
        byte i;
        for (i = 0; i < height; ++i) {
            if (y < VVramHeight) {
                repeat (Width) {
                    *pVVram = c; ++pVVram;
                    c += Height + 1;
                }
                pVVram += VVramWidth - Width;
                c += 1 - (Height + 1) * Width;
            }
            else {
                ++c;
                pVVram += VVramWidth;
            }
            ++y;
        }
    }
}