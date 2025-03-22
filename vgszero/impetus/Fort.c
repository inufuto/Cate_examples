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
constexpr byte Left = (WindowWidth - Width) / 2;
constexpr byte FortX = Left * CoordRate;
constexpr byte MaxY = (4 + Height) * CoordRate;
constexpr byte RangeY = WindowHeight * CoordRate;
constexpr byte MaxLife = 10;
constexpr word Point = 50;

byte FortY;
byte FortLife;
static byte localClock;
static byte bulletX;

void InitFort()
{
    FortLife = 0;
    FortY = RangeY;
}

static void UpdatePosition()
{
    byte sprite = Sprite_FortElement;
    byte pattern = Pattern_Fort;
    byte spriteBottom = FortY - (Height - 2) * CoordRate;
    repeat (Height / 2) {
        if (spriteBottom >= 0) {
            byte x = FortX;
            byte y = spriteBottom - 2 * CoordRate;
            repeat (Width / 2) {
                ShowSprite(sprite, x, y, pattern);
                x += 2 * CoordRate;
                ++sprite;
                ++pattern;
            }
        }
        else {
            pattern += Width / 2;
        }
        spriteBottom += 2 * CoordRate;
    }
}


void StartFort()
{
    FortY = 0;
    FortLife = MaxLife;
    localClock = 0;
    bulletX = FortX;
    UpdatePosition();
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
            
            byte sprite = Sprite_FortElement;
            repeat (Width / 2 * Height / 2) {
                HideSprite(sprite);
                ++sprite;
            }
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
