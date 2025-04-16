#include "Barrier.h"
#include "Sprite.h"
#include "Math.h"
#include "Main.h"
#include "VVram.h"
#include "Chars.h"
#include "VVram.h"
#include "Bang.h"
#include "Fighter.h"
// #include "Sound.h"

constexpr byte Count = 2;
constexpr byte RangeY = VVramHeight;
constexpr byte InvalidY = 0xff;
constexpr byte MaxLength = 10;

Barrier[Count] Barriers;

void InitBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        pBarrier->y = InvalidY;
    }
}


static void Hide(ptr<Barrier> pBarrier)
{
    pBarrier->y = InvalidY;
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
            if (x + length >= VVramHeight - 1) return;
            pBarrier->left = x;
            pBarrier->right = pBarrier->left + 1 + length;
            pBarrier->y = 0;
            pBarrier->length = length;
            return;
        }
    }
}

void DrawBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y < RangeY) {
            ptr<byte> pVVram;
            byte count;
            pVVram = VVramPtr(pBarrier->left, pBarrier->y);
            *pVVram = Char_BarrierHead;
            ++pVVram;
            count = pBarrier->length;
            do {
                *pVVram = Char_Barrier;
                ++pVVram;
                --count;
            } while (count != 0);
            *pVVram = Char_BarrierHead;
        }
    }
}

void MoveBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;
        ++pBarrier->y;
    }
}


static void Destroy(ptr<Barrier> pBarrier, byte x)
{
    // Sound_SmallBang();
    // Sound_Hit();
    StartBang(x, pBarrier->y, false);
    Hide(pBarrier);
    AddScore(pBarrier->length);
}


bool HitBulletBarrier(byte x, byte y)
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y >= RangeY) continue;

        if (y + 1 >= pBarrier->y && y < pBarrier->y + 1) {
            byte leftRight;
            leftRight = pBarrier->left + 1;
            if (
                x + 1 >= pBarrier->left &&
                x < leftRight
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                x + 1>= pBarrier->right &&
                x < pBarrier->right + 1
            ) {
                Destroy(pBarrier, pBarrier->right);
                return true;
            }
            if (
                x + 1 >= leftRight &&
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
            FighterY + 1 >= pBarrier->y &&
            FighterY - 1 < pBarrier->y
        ) {
            byte leftRight, fighterRight;
            leftRight = pBarrier->left + 1;
            fighterRight = FighterX + 2;
            if (
                pBarrier->left < fighterRight &&
                FighterX < leftRight
            ) {
                Destroy(pBarrier, pBarrier->left);
                return true;
            }
            if (
                pBarrier->right < fighterRight &&
                FighterX < pBarrier->right + 1
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