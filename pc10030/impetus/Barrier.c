#include "Barrier.h"
#include "VVram.h"
#include "Sprite.h"
#include "Math.h"
#include "Main.h"
#include "Chars.h"
#include "Stage.h"
#include "Bang.h"
#include "Fighter.h"
#include "Sound.h"

extern void _deb();

constexpr byte Count = 4 / 2;
constexpr byte RangeY = (VVramHeight - 1) * CoordRate;
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
        pBarrier->newY = InvalidY;
        pBarrier->oldY = InvalidY;
        sprite += 2;
    }
}


static void Locate(ptr<Barrier> pBarrier)
{
    ShowSprite(
        pBarrier->sprite, pBarrier->left, pBarrier->y, Pattern_BarrierHead
    );
    ShowSprite(
        pBarrier->sprite + 1, pBarrier->right, pBarrier->y, Pattern_BarrierHead
    );
}

static void End(ptr<Barrier> pBarrier)
{
    pBarrier->y = InvalidY;
    pBarrier->newY = InvalidY;
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
            pBarrier->oldY = 0;
            pBarrier->newY = 0;
            Locate(pBarrier);
            return;
        }
    }
}


void DrawBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->newY < VVramHeight) {
            byte c, count;
            ptr<byte> pVVram;
            c = Char_Barrier + ((pBarrier->y + CoordRate / 2) & CoordMask);
            count = pBarrier->length;
            pVVram = VVramPtr((pBarrier->left >> CoordShift) + 1, pBarrier->newY);
            do {
                *pVVram = c;
                ++pVVram;
                --count;
            } while (count != 0);
        }
        pBarrier->oldY = pBarrier->newY;
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
            byte mod;
            if ((pBarrier->y & CoordMask) == CoordRate / 2) {
                ++pBarrier->newY;
            }
            Locate(pBarrier);
            // BackgroundChanged = true;
        }
    }
}


static void Destroy(ptr<Barrier> pBarrier, byte x)
{
    // Sound_SmallBang();
    Sound_Hit();
    if (x < CoordRate / 2) {
        x = CoordRate / 2;
    }
    StartBang(x + CoordRate / 2, pBarrier->y + CoordRate / 2, false);
    End(pBarrier);
    AddScore(pBarrier->length);
}


bool HitBulletBarrier(byte x, byte y)
{
    ptr<Barrier> pBarrier;
    x += CoordRate - 1;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;

        if (
            y + CoordRate / 2 >= pBarrier->y &&
            y - CoordRate / 2 < pBarrier->y
        ) {
            byte leftRight;
            leftRight = pBarrier->left + CoordRate;
            if (
                x >= pBarrier->left &&
                x < leftRight
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                x >= pBarrier->right &&
                x < pBarrier->right + CoordRate
            ) {
                Destroy(pBarrier, pBarrier->right);
                return true;
            }
            if (
                x >= leftRight &&
                x < pBarrier->right
            ) {
                return true;
            }
        }
    }
    return false;
}


bool HitFighterBarrier()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;

        if (
            FighterY + CoordRate >= pBarrier->y &&
            FighterY - CoordRate < pBarrier->y
        ) {
            byte leftRight, fighterRight;
            leftRight = pBarrier->left + CoordRate;
            fighterRight = FighterX + CoordRate * 2;
            if (
                pBarrier->left < fighterRight &&
                FighterX < leftRight
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                pBarrier->right < fighterRight &&
                FighterX < pBarrier->right + CoordRate
            ) {
                Destroy(pBarrier, pBarrier->right);
                return true;
            }
            if (
                leftRight < fighterRight &&
                FighterX < pBarrier->right
            ) {
                return true;
            }
        }
    }
    return false;
}