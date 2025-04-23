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
constexpr byte FortX = Left;
constexpr byte MaxY = 4 + Height;
// constexpr byte CharCount = Width * (Height + 1);
constexpr byte MaxLife = 10;
constexpr word Point = 50;
constexpr byte Color = 0xb8;

byte FortY;
byte FortLife;
// byte FortCharOffset;
static byte oldY, oldHeight;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
}


void StartFort()
{
    // FortCharOffset = 0;
    FortY = 1;
    FortLife = MaxLife;
    bulletX = FortX;
    oldY = 0;
    oldHeight = 0;
}


void DrawFort()
{
    byte y, height, bits, c;
    ptr<byte> pFront;
    
    if (FortLife == 0) return;

    y = FortY - Height;
    height = Height;
    bits = 0x3f;
    c = Char_Fort;
    while (y >= VVramHeight) {
        ++y;
        --height;
        bits >> 1;
        c += Width;
    }

    oldY = y;
    oldHeight = height;
    pFront = VVramFront + VVramOffset(Left, y);
    do {
        repeat(Width) {
            *pFront = c;
            ++c;
            ++pFront;
        }
        pFront += VVramWidth - Width;
        --height;
    } while (height != 0);
    SetRowFlags(y, bits);
}


void EraseFort()
{
    word offset;
    ptr<byte> pBack, pFront;
    byte count, bits;
    
    if (FortLife == 0) return;

    count = oldHeight;
    if (oldY < VVramHeight && count != 0) {
        bits = 0;
        offset = VVramOffset(Left, oldY);
        pFront = VVramFront + offset;
        pBack = VVramBack + offset;
        do {
            repeat(Width) {
                *pFront = *pBack;
                ++pFront;
                ++pBack;
            }
            pFront += VVramWidth;
            pBack += VVramWidth;
            bits = (bits << 1) | 1;
            --count;
        } while (count != 0);
        SetRowFlags(oldY, bits);
    }
}


void MoveFort()
{
    if (FortLife != 0) {
        byte y;
        if (FortY < MaxY) {
            ++FortY;
            // FortCharOffset ^= CharCount;
            // SetFortPattern();
        }
        y = FortY - 1;
        repeat (Height / 2 - 1) {
            bulletX += 1;
            if (bulletX >= FortX + Width) {
                bulletX = FortX;
            }
            if (Rnd() < CurrentStage + 3) {
                StartEnemyBullet(bulletX, y);
            }
            y -= 1;
        }
    }
}


bool HitFort(byte x, byte y)
{
    if (FortLife == 0) return;
    if (
        x + 1 >= FortX && x < FortX + Width && y < FortY
    )  {
        --FortLife;
        if (FortLife == 0) {
            Sound_LargeBang();
            StartBang(FortX + Width / 2, FortY - Height / 2, true);
            AddScore(Point);
            VVramChanged = true;
            DrawAll();
        }
        else {
            Sound_SmallBang();
            StartBang(x + 1, y + 1, false);
        }
        // Sound_Hit();
        return true;
    }
    return false;
}
