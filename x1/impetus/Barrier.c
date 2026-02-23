#include "Barrier.h"
#include "Sprite.h"
#include "Vram.h"
#include "Math.h"
#include "Main.h"
#include "VVram.h"
#include "Chars.h"
#include "Stage.h"
#include "Bang.h"
#include "Fighter.h"
#include "Sound.h"

constexpr byte Count = (Sprite_SkyEnemy - Sprite_BarrierHead) / 2;
constexpr byte RangeY = (VVramHeight - 1) * CoordRate + 1;
constexpr byte InvalidY = 0xff;
constexpr byte MaxLength = 10;

Barrier[Count] Barriers;

void InitBarriers()
{
    byte sprite;
    ptr<Barrier> pBarrier;
    sprite = Sprite_BarrierHead;
    for (pBarrier : Barriers) {
        pBarrier->sprite = sprite;
        pBarrier->y = InvalidY;
        pBarrier->oldY = InvalidY;
        sprite += 2;
    }
}


static void Locate(ptr<Barrier> pBarrier)
{
    ShowSprite(
        pBarrier->sprite, pBarrier->left, pBarrier->y, GChar_BarrierHead
    );
    ShowSprite(
        pBarrier->sprite + 1, pBarrier->right, pBarrier->y, GChar_BarrierHead
    );
}

static void End(ptr<Barrier> pBarrier)
{
    pBarrier->y = InvalidY;
    HideSprite(pBarrier->sprite);
    HideSprite(pBarrier->sprite + 1);
}

void StartBarrier()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) {
            byte x, length;
            x = (Rnd() & 0x0f) << 1;
            length = CurrentStage + 3;
            if (length > MaxLength) length = MaxLength;
            if (x + length >= VVramWidth - 1) return;
            pBarrier->left = x << CoordShift;
            pBarrier->right = pBarrier->left + CoordRate + (length << CoordShift);
            pBarrier->y = 0;
            pBarrier->length = length;
            Locate(pBarrier);
            return;
        }
    }
}


void DrawBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y < RangeY) {
            byte y, c, count;
            ptr<byte> pFront;
            c = Char_Barrier + (pBarrier->y & CoordMask);
            count = pBarrier->length;
            y = pBarrier->y >> CoordShift;
            pFront = VVramFront + VVramOffset((pBarrier->left >> CoordShift) + 1, y);
            do {
                *pFront = c;
                ++pFront;
                --count;
            } while (count != 0);
            if (pBarrier->y != pBarrier->oldY) {
                SetTRowFlags(y, 1);
            }
        }
        pBarrier->oldY = pBarrier->y;
    }
}

void EraseBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (
            pBarrier->oldY < RangeY &&
            pBarrier->y != pBarrier->oldY
        ) {
            byte count, y;
            word offset;
            ptr<byte> pBack, pFront;
            count = pBarrier->length;
            y = pBarrier->oldY >> CoordShift;
            offset = VVramOffset((pBarrier->left >> CoordShift) + 1, y);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            do {
                *pFront = *pBack + charOffset;
                ++pFront;
                ++pBack;
                --count;
            } while (count != 0);
            SetTRowFlags(y, 1);
        }
    }
}


void MoveBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;
        ++pBarrier->y;
        if (pBarrier->y >= RangeY) {
            End(pBarrier);
        }
        else {
            Locate(pBarrier);
        }
    }
}


static void Destroy(ptr<Barrier> pBarrier, byte x)
{
    Sound_SmallBang();
    if (x < CoordRate / 2) {
        x = CoordRate / 2;
    }
    StartBang(x + CoordRate / 2, pBarrier->y + CoordRate / 2, false);
    End(pBarrier);
    AddScore(pBarrier->length);
}


bool HitBulletBarrier(byte x, byte y)
{
    constexpr byte BulletSize = CoordRate;
    constexpr byte HeadSize = CoordRate;
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;

        if (
            pBarrier->y < y + BulletSize &&
            y < pBarrier->y + HeadSize
        ) {
            byte bulletLeft;
            bulletLeft = x + BulletSize;
            if (
                pBarrier->left < bulletLeft + 1 &&
                bulletLeft < pBarrier->left + (HeadSize + 1)
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                pBarrier->right < bulletLeft + 1 &&
                bulletLeft < pBarrier->right + (HeadSize + 1)
            ) {
                Destroy(pBarrier, pBarrier->right);
                return true;
            }
            if (
                pBarrier->left < x &&
                bulletLeft < pBarrier->right
            ) {
                return true;
            }
        }
    }
    return false;
}


bool HitFighterBarrier()
{
    constexpr byte FighterSize = CoordRate * 2;
    constexpr byte HeadSize = CoordRate * 1;

    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;

        if (
            pBarrier->y - FighterSize < FighterY &&
            FighterY - HeadSize < pBarrier->y
        ) {
            if (
                pBarrier->left - FighterSize < FighterX &&
                FighterX - HeadSize < pBarrier->left
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                pBarrier->right - FighterSize < FighterX &&
                FighterX - HeadSize < pBarrier->right
            ) {
                Destroy(pBarrier, pBarrier->right);
                return true;
            }
            if (
                pBarrier->left + HeadSize - FighterSize < FighterX &&
                FighterX < pBarrier->right
            ) {
                return true;
            }
        }
    }
    return false;
}