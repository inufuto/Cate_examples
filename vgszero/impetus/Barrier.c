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

constexpr byte SpriteCount = 6;
constexpr byte MaxCount = MaxBarrierElementCount / SpriteCount;
constexpr byte RangeY = (WindowHeight - 1) * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte MaxLength = 10;

Barrier[MaxCount] Barriers;

void InitBarriers()
{
    byte sprite;
    ptr<Barrier> pBarrier;
    sprite = Sprite_BarrierElement;
    for (pBarrier : Barriers) {
        pBarrier->sprite = sprite;
        pBarrier->y = InvalidY;
        pBarrier->oldY = InvalidY;
        sprite += SpriteCount;
    }
}


static void Show(ptr<Barrier> pBarrier)
{
    byte sprite = pBarrier->sprite;
    byte x = pBarrier->left;
    byte y = pBarrier->y;
    byte count = pBarrier->length;
    ShowSprite(sprite, x, y, Pattern_BarrierLeft);
    ++sprite;
    x += 16;
    count -= 1;
    while (count >= 2) {
        ShowSprite(sprite, x, y, Pattern_BarrierCenter);
        ++sprite;
        x += 16;
        count -= 2;
    }
    if (count == 0) {
        x -= 8;
    }
    ShowSprite(sprite, x, y, Pattern_BarrierRight);
}

static void Hide(ptr<Barrier> pBarrier)
{
    pBarrier->y = InvalidY;
    byte sprite = pBarrier->sprite;
    repeat (SpriteCount) {
        HideSprite(sprite);
        ++sprite;
    }
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
            if (x + length >= WindowWidth - 1) return;
            pBarrier->left = x << CoordShift;
            pBarrier->right = pBarrier->left + CoordRate + (length << CoordShift);
            pBarrier->y = 0;
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
        if (pBarrier->y >= RangeY) continue;

        ++pBarrier->y;
        if (pBarrier->y >= RangeY) {
            Hide(pBarrier);
        }
        else {
            Show(pBarrier);
        }
    }
}


static void Destroy(ptr<Barrier> pBarrier, byte x)
{
    Sound_SmallBang();
    // Sound_Hit();
    if (x < CoordRate / 2) {
        x = CoordRate / 2;
    }
    StartBang(x + CoordRate / 2, pBarrier->y + CoordRate / 2, false);
    Hide(pBarrier);
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