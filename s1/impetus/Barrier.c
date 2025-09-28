#include "Barrier.h"
#include "Sprite.h"
#include "Vram.h"
#include "Math.h"
#include "Main.h"
#include "Chars.h"
#include "Stage.h"
#include "Bang.h"
#include "Fighter.h"
#include "Sound.h"

constexpr byte Count = (Sprite_FighterBullet - Sprite_BarrierHead) / 2;
constexpr byte RangeY = (StageHeight - 1) * CoordRate;
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
    BackgroundChanged = true;
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
            if (x + length >= StageWidth - 1) return;
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
        if (pBarrier->y >= RangeY) continue;
        byte x = (pBarrier->left >> CoordShift) + 1;
        byte y = pBarrier->y + CoordRate / 2;
        byte mod = y & CoordMask;
        y >>= CoordShift;
        if (y < StageHeight) {
            byte c = Char_Barrier + mod;
            byte count = pBarrier->length;
            word vram = NextPage() + VramOffset(x, y);
            do {
                vram = WriteTVram(vram, c);
                --count;
            } while (count != 0);
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
    BackgroundChanged = true;
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