#include "Fort.h"
#include "Chars.h"
#include "Vram.h"
#include "Main.h"
#include "Stage.h"
#include "Movable.h"
#include "Sound.h"
#include "Bang.h"
#include "Math.h"
#include "EnemyBullet.h"
#include "MyFighter.h"

constexpr byte Count = 6;
constexpr byte FortWidth = 8;
constexpr byte FortHeight = 4;
constexpr byte InterY = FortHeight * 2;
constexpr byte InvalidY = 0xff;
constexpr byte TopY = 2;
constexpr byte FortCharCount = (Char_End - Char_Fort) / 2;
constexpr byte RangeX = VramWidth;
constexpr byte Left = 12;   //VramWidth - 20;
constexpr byte MaxLife = 20;
constexpr byte Pts = 80;
constexpr byte FireMask = (CoordRate << 2) - 1;

Fort[Count] Forts;
byte FortCount;
byte FortCharOffset;
byte FortDotOffset;
static bool moving;

void InitForts()
{
    ptr<Fort> pFort;
    for (pFort: Forts) {
        pFort->y = InvalidY;
    }
    FortCount = 0;
    moving = false;
}


static void Draw(ptr<Fort> pFort)
{
    word vram0;
    byte x, y, w, c0, c1;
    bool space;
    x = pFort->x;
    if (x >= RangeX) return;
    vram0 = VramAddress(x, pFort->y + TopY);
    if (x < RangeX - FortWidth) {
        w = FortWidth;
        space = x < RangeX - FortWidth;
    }
    else {
        w = RangeX - x;
        space = false;
    }
    c0 = FortCharOffset + Char_Fort;
    repeat (FortHeight) {
        word vram1;
        byte i;
        vram1 = vram0;
        i = w;
        c1 = c0;
        do {
            vram1 = Put(vram1, c1);
            ++c1;
            --i;
        } while (i != 0);
        if (space) {
            Put(vram1, Char_Space);
        }
        vram0 += VramWidth;
        c0 += FortWidth;
    }
}


static void End(ptr<Fort> pFort)
{
    word vram0;
    byte x, y, w, c;
    x = pFort->x;
    if (x >= RangeX) return;
    vram0 = VramAddress(x, pFort->y + TopY);
    if (x < RangeX - FortWidth) {
        w = FortWidth;
    }
    else {
        w = RangeX - x;
    }
    repeat (FortHeight) {
        word vram1;
        byte i;
        vram1 = vram0;
        i = w;
        do {
            vram1 = Put(vram1, Char_Space);
            --i;
        } while (i != 0);
        vram0 += VramWidth;
    }
    pFort->y = InvalidY;
    --FortCount;
}


void StartForts()
{
    byte i, x, y;
    ptr<Fort> pFort;
    FortCount = 0;
    i = (CurrentStage + 2) >> 1;
    if (i > Count) {
        i = Count;
    }
    pFort = Forts;
    x = RangeX;
    y = 0;
    do {
        byte targetX;
        targetX = x - (RangeX - Left);
        if (targetX >= RangeX - FortWidth) break;
        pFort->x = x;
        pFort->targetX = targetX;
        pFort->y = y;
        pFort->life = MaxLife;
        pFort->clock = 0;
        ++FortCount;
        ++pFort;
        y += FortHeight * 3 / 2;
        if (y + FortHeight > MinGroundY) {
            x += FortWidth * 4 / 3;
            y = 0;
        }
        --i;
    } while (i != 0);
    FortDotOffset = 0;
    FortCharOffset = 0;
    moving = true;
}


static void Fire(ptr<Fort> pFort)
{
    if (
        (pFort->clock & FireMask) == 0 &&
        pFort->x < (RangeX - 2) //&&
        //Rnd() < CurrentStage + 4
    ) {
        byte x, y;
        ptr<Bullet> pBullet;
        x = (pFort->x + 2) << CoordShift;
        y = (pFort->y + 2) << CoordShift;
        pBullet = StartEnemyBullet(x, y);
        if (pBullet != nullptr) {
            pBullet->dx = -1;
            pBullet->dy = Sign(y, MyFighter.y);
            if (pBullet->dy != 0) {
                byte lx, ly;
                lx = Abs(x, MyFighter.x);
                ly = Abs(y, MyFighter.y);
                if (lx < ly) {
                    pBullet->numeratorX = ShortVelocity * 4 / 3;
                    pBullet->numeratorY = LongVelocity * 4 / 3;
                }
                else if (lx > ly) {
                    pBullet->numeratorX = LongVelocity * 4 / 3;
                    pBullet->numeratorY = ShortVelocity * 4 / 3;
                }
                else {
                    pBullet->numeratorX = LoVelocity * 4 / 3;
                    pBullet->numeratorY = LoVelocity * 4 / 3;
                }
            }
            else {
                pBullet->numeratorX = HiVelocity * 4 / 3;
                pBullet->numeratorY = HiVelocity * 4 / 3;
            }
        }
    }
}


void MoveForts()
{
    if (moving) {
        if (FortDotOffset == 0) {
            ptr<Fort> pFort;
            FortCharOffset ^= FortCharCount;
            SetFortChars();
            for (pFort: Forts) {
                if (pFort->y == InvalidY) continue;
                if (pFort->x > pFort->targetX) {
                    --pFort->x;
                    Draw(pFort);
                }
                else {
                    moving = false;
                }
                Fire(pFort);
            }
            if (!moving) return;
        }
        else {
            SetFortChars();
        }
        FortDotOffset = (FortDotOffset + 1) & 7;
    }
    else {
        ptr<Fort> pFort;
        for (pFort: Forts) {
            if (pFort->y == InvalidY) continue;
            Fire(pFort);
            ++pFort->clock;
        }
    }
}


bool HitBulletFort(byte x, byte y)
{
    ptr<Fort> pFort;
    byte xx, yy;
    xx = (x >> CoordShift) - 1;
    yy = ((y + CoordRate / 2) >> CoordShift);
    for (pFort: Forts) {
        if (pFort->y == InvalidY) continue;
        if (
            xx >= pFort->x &&
            xx < pFort->x + (FortWidth - 2) &&
            yy  >= pFort->y &&
            yy < pFort->y + (FortHeight)
        ) {
            if (--pFort->life ==0) {
                Sound_LargeBang();
                StartLargeBang(
                    (pFort->x + FortWidth / 2) << CoordShift,
                    (pFort->y + FortHeight / 2) << CoordShift
                );
                End(pFort);
                AddScore(Pts);
            }
            else {
                Sound_SmallBang();
                StartSmallBang(x + CoordRate, y + CoordRate);
            }
            return true;
        }
    }
    return false;
}