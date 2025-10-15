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
    ptr<byte> pVVram;
    
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
    pVVram = VVramPtr(Left, y);
    do {
        repeat(Width) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - Width;
        --height;
    } while (height != 0);
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
    if (FortLife == 0) return false;
    if (
        x + 1 >= FortX && x < FortX + Width && y < FortY
    )  {
        --FortLife;
        if (FortLife == 0) {
            Sound_LargeBang();
            StartBang(FortX + Width / 2, FortY - Height / 2, true);
            AddScore(Point);
            // VVramChanged = true;
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
