#include "Fort.h"
#include "Sprite.h"
#include "Vram.h"
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
byte FortCharOffset;
static byte oldY;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
}


void StartFort()
{
    FortCharOffset = 0;
    FortY = 1;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
}


void DrawFort()
{
    byte y;
    byte height;
    byte c;
    ptr<byte> pVVram;
    
    if (FortLife == 0) return;

    c = Char_Fort + FortCharOffset;
    height = Height;
    y = (FortY >> CoordShift) - Height;
    while (y >= VVramHeight) {
        ++y;
        --height;
        c += Width;
    }
    if ((FortY & CoordMask) != 0) {
        ++height;
    }

    oldY = y;
    pVVram = VVram + VVramOffset(Left, y);
    do {
        repeat(Width) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - Width;
        --height;
        SetRowFlag(y);
        ++y;
    } while (height != 0);
}


void EraseFort()
{
    byte y;
    word offset;
    ptr<byte> pGround, pVVram;
    
    if (FortLife == 0) return;
   
    y = (FortY >> CoordShift) - Height;
    if (oldY < VVramHeight && y != oldY) {
        y = oldY;
        offset = VVramOffset(Left, y);
        pVVram = VVram + offset;
        pGround = Ground + VVramWidth * TileSize + offset;
        repeat(Height + 1) {
            repeat(Width) {
                *pVVram = *pGround;
                ++pVVram;
                ++pGround;
            }
            pVVram += VVramWidth - Width;
            pGround += VVramWidth - Width;
            SetRowFlag(y);
            ++y;
        }
    }
}


void MoveFort()
{
    if (FortLife != 0) {
        if (FortY < MaxY) {
            ++FortY;
            FortCharOffset ^= CharCount;
            SetFortPattern();
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
    if (FortLife == 0) return;
    x += CoordRate - 1;
    if (
        x >= FortX && x < FortX + Width * CoordRate && y < FortY
    )  {
        --FortLife;
        if (FortLife == 0) {
            Sound_LargeBang();
            StartBang(FortX + CoordRate * Width / 2, FortY - CoordRate * Height / 2, true);
            AddScore(Point);
            GroundChanged = true;
            DrawAll();
        }
        else {
            Sound_SmallBang();
            StartBang(x, y, false);
        }
        return true;
    }
    return false;
}
