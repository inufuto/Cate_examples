#include "Barrier.h"
#include "Sprite.h"
#include "Vram.h"
#include "Math.h"
#include "Main.h"
#include "Chars.h"
#include "Bang.h"
#include "Main.h"
#include "Fighter.h"
#include "Sound.h"

constexpr byte MaxLength = 10;
constexpr byte InitialY = -CoordRate * 2;
constexpr byte RangeY = VramHeight * CoordRate;
constexpr byte InvalidY = VramHeight * CoordRate;

Barrier[MaxBarrierCount] Barriers;

void InitBarriers()
{
    byte sprite = Sprite_Barrier;
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        pBarrier->sprite = sprite;
        pBarrier->y = InvalidY;
        sprite += 3;
    }
}

static void Show(ptr<Barrier> pBarrier)
{
    byte sprite = pBarrier->sprite;
    ShowSpriteXY(sprite, pBarrier->left, pBarrier->y, Pattern_BarrierLeft);
    ++sprite;
    ShowSpriteXY(sprite, pBarrier->right, pBarrier->y, Pattern_BarrierRight);
    ++sprite;
    ShowSpriteXY(sprite, pBarrier->center, pBarrier->y, Pattern_BarrierCenter);
}

static void End(ptr<Barrier> pBarrier)
{
    pBarrier->y = InvalidY;
    byte sprite = pBarrier->sprite;
    repeat (3) {
        HideSprite(sprite);
        ++sprite;
    }
}

void StartBarrier()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y == InvalidY) {
            byte x = (Rnd() & 0x0f) << 1;
            byte length = CurrentStage + 3;
            if (length > MaxLength) length = MaxLength;
            if (x + length >= VramWidth - 1) return;
            x <<= CoordShift;
            pBarrier->left = x;
            pBarrier->center = x;
            pBarrier->right = pBarrier->left + (length << CoordShift);
            pBarrier->y = InitialY;
            pBarrier->length = length;
            Show(pBarrier);
            return;
        }
    }
}


void MoveBarriers()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y != InvalidY) {
            ++pBarrier->y;
            byte center = pBarrier->center + CoordRate;
            if (center >= pBarrier->right) {
                center = pBarrier->left;
            }
            pBarrier->center = center;
            if (pBarrier->y - InitialY >= RangeY - InitialY) {
                End(pBarrier);
            }
            else {
                Show(pBarrier);
            }
        }
    }
}


static void Destroy(ptr<Barrier> pBarrier, byte x)
{
    Sound_SmallBang();
    Sound_Hit();
    if (x < CoordRate / 2) {
        x = CoordRate / 2;
    }
    StartSmallBang(x + CoordRate / 2, pBarrier->y + CoordRate / 2);
    End(pBarrier);
    AddScore(pBarrier->length);
}

bool HitBulletBarrier(byte x, byte y)
{
    x += CoordRate;
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y != InvalidY) {
            if (
                y + CoordRate >= pBarrier->y &&
                y - CoordRate < pBarrier->y
            ) {
                byte leftRight = pBarrier->left + CoordRate;
                if (x >= pBarrier->left && leftRight >= x) {
                    Destroy(pBarrier, pBarrier->left);
                    return true;
                }
                byte right = pBarrier->right + CoordRate;
                if (x >= right && right + CoordRate >= x) {
                    Destroy(pBarrier, right);
                    return true;
                }
                if (x >= leftRight && right >= x) {
                    return true;
                }
            }
        }
    }
    return false;
}


bool HitFighterBarrier()
{
    ptr<Barrier> pBarrier;
    for (pBarrier : Barriers) {
        if (pBarrier->y != InvalidY) {
            if (
                Fighter.y + CoordRate >= pBarrier->y &&
                Fighter.y - CoordRate < pBarrier->y
            ) {
                byte leftRight = pBarrier->left + CoordRate;
                byte fighterRight = Fighter.x + CoordRate * 2;
                if (pBarrier->left < fighterRight && Fighter.x < leftRight
                ) {
                    Destroy(pBarrier, pBarrier->left);
                    return true;
                }
                byte right = pBarrier->right + CoordRate;
                if (right < fighterRight && Fighter.x < right + CoordRate) {
                    Destroy(pBarrier, right);
                    return true;
                }
                if (leftRight < fighterRight && Fighter.x < right) {
                    return true;
                }
            }
        }
    }
    return false;
}