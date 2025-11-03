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

constexpr byte MaxCount = 4 * 2;
// constexpr byte InvalidY = -VramHeight;
constexpr byte MaxLife = 10;
constexpr byte Width = 6;
constexpr byte Height = 6;
constexpr word Point = 50;

Fort[MaxCount] Forts;
byte FortCount;
// byte FortDotOffset;
// byte FortCharOffset;
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
        8 + 1, 16 + 1, 1, 24 + 1       
    };
    byte count = CurrentStage + 1;
    if (count > MaxCount) count = MaxCount;
    bool odd = (count & 1) != 0;
    byte rc = count >> 2;
    byte targetY = 8 + 2;
    ptr<Fort> pFort = Forts;
    byte i = 0;
    do {
        byte x = positions[i & 3];
        if (odd && rc == 0) {
            x += 4;
        }
        pFort->x = x;
        pFort->y = targetY - (16 + 2);
        pFort->targetY = targetY;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++pFort;
        ++i;
        if ((i & 3) == 0) {
            targetY -= 8;
            rc = 0;
        }
    } while (i != count);
    FortCount = count;
    // FortDotOffset = 0;
    // FortCharOffset = 0;
    moving = true;
}


static void Fire(ptr<Fort> pFort)
{
    ++pFort->clock;
    if ((pFort->clock & CoordMask) == 0) {
        byte y = pFort->y;
        if (y < VramHeight) {
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

void DrawForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->life != 0) {
            DrawFort(pFort->x, pFort->y);
            // PollVSync();
        }
    }
}

void MoveForts()
{
    if (moving) {
        // FortDotOffset = (FortDotOffset + 1) & CoordMask;
        // if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            for (pFort: Forts) {
                if (pFort->life != 0) {
                    if (pFort->y != pFort->targetY) {
                        ++pFort->y;
                        if (pFort->y == pFort->targetY) {
                            moving = false;
                        }
                    }
                    Fire(pFort);
                    // PollVSync();
                }
            }
        // }
    }
    else {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->life != 0) {
                Fire(pFort);
                // PollVSync();
            }
        }
    }
}


bool HitFort(byte x, byte y)
{
    byte xx = (x + 1) >> CoordShift;
    byte yy = y >> CoordShift;
    ptr<Fort> pFort;
    for (pFort: Forts) {
        if (pFort->life != 0) {
            byte height = Height;
            byte fortY = pFort->y;
            if (fortY >= VramHeight) {
                height += fortY;
                fortY = 0;
            }
            if (
                height <= Height &&
                xx >= pFort->x && pFort->x + Width >= xx &&
                yy >= fortY && fortY + height >= yy
            )  {
                --pFort->life;
                if (pFort->life == 0) {
                    // Sound_LargeBang();
                    StartLargeBang(
                        (pFort->x + Width / 2) << CoordShift,
                        (pFort->y + Height / 2) << CoordShift
                    );
                    AddScore(Point);
                    --FortCount;
                    if (FortCount == 0) {
                        moving = false;
                    }
                }
                else {
                    // Sound_SmallBang();
                    StartSmallBang(x + CoordRate, y);
                }
                Sound_Hit();
                return true;
            }
        }
    }
    return false;
}