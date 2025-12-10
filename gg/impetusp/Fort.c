#include "Fort.h"
#include "Vram.h"
#include "Main.h"
#include "Chars.h"
#include "Stage.h"
#include "Movable.h"
#include "Bang.h"
#include "EnemyBullet.h"
#include "Math.h"
#include "Sound.h"

extern void _deb();

constexpr byte MaxCount = 3;
constexpr byte MaxLife = 10;
constexpr byte Width = 6;
constexpr byte Height = 6;
constexpr word Point = 50;
constexpr byte TargetY = 4;

Fort[MaxCount] Forts;
byte FortCount;
byte FortDotOffset;
byte FortCharOffset;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->life = 0;
    }
    FortCount = 0;
    moving = false;
}


void StartForts()
{
    static const byte[] positions = {
        7, 1, 13
    };
    byte count = CurrentStage + 1;
    if (count > MaxCount) count = MaxCount;
    ptr<Fort> pFort = Forts;
    byte i = 0;
    do {
        byte x = positions[i & 3];
        if ((count & 1) == 0) {
            x += 3;
        }
        pFort->x = x;
        pFort->y = -8;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++pFort;
        ++i;
    } while (i != count);
    FortCount = count;
    FortDotOffset = 0;
    FortCharOffset = 0;
    moving = true;
}


static void Fire(ptr<Fort> pFort)
{
    ++pFort->clock;
    if ((pFort->clock & CoordMask) == 0) {
        byte y = pFort->y;
        if (y < WindowHeight) {
            repeat (Height) {
                if (Rnd() < CurrentStage + 3) {
                    byte x = (Rnd() & 3) + pFort->x + 1;
                    StartEnemyBullet(x << CoordShift, y << CoordShift);
                    return;
                }
                ++y;
            }
        }
    }
}

static void Draw()
{
    DrawGround();
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->life != 0) {
            if (pFort->y != TargetY) {
                ++pFort->y;
                if (pFort->y == TargetY) {
                    moving = false;
                }
            }
            DrawFort(pFort->x, pFort->y);
            Fire(pFort);
        }
    }
    StatusToVram();
    SwitchVram();
}

void MoveForts()
{
    if (moving) {
        if (FortDotOffset == 0) {
            FortCharOffset ^= (Char_Fort1 - Char_Fort0);
            UpdateFortChars();
            Draw();
            if (!moving) return;
        }
        else {
            UpdateFortChars();
        }
        FortDotOffset = (FortDotOffset + 1) & CoordMask;
    }
    else {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->life != 0) {
                Fire(pFort);
            }
        }
    }
}


bool HitFort(byte x, byte y)
{
    byte xx = x >> CoordShift;
    byte yy = y >> CoordShift;
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->life != 0) {
            byte height = Height;
            byte fortY = pFort->y;
            if (fortY >= WindowHeight) {
                height += fortY;
                fortY = 0;
            }
            if (
                height <= Height &&
                xx >= pFort->x && xx < pFort->x + Width &&
                yy >= fortY && yy < fortY + height
            )  {
                --pFort->life;
                if (pFort->life == 0) {
                    Sound_LargeBang();
                    StartLargeBang(
                        (pFort->x + Width / 2) << CoordShift,
                        (pFort->y + Height / 2) << CoordShift
                    );
                    AddScore(Point);
                    if (!moving) {
                        Draw();
                    }
                    --FortCount;
                    if (FortCount == 0) {
                        moving = false;
                    }
                }
                else {
                    Sound_SmallBang();
                    StartSmallBang(x + CoordRate, y);
                }
                return true;
            }
        }
    }
    return false;
}