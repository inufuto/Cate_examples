#include "Monster.h"
#include "Stage.h"
#include "Rock.h"
#include "Sprite.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Man.h"

ptr<byte> InitMonsters(ptr<Movable> pMonster, byte maxCount, byte sprite, ptr<byte> pStage)
{
    byte count, i;

    count = *pStage;
    ++pStage;

    i = 0;
    while (i < count) {
        byte b;
        b = *pStage;
        ++pStage;
        
        pMonster->status = Movable_Status_Live;
        pMonster->sprite = sprite;
        ++sprite;
        ++pMonster;
        ++i;
    }
    while (i < maxCount) {
        pMonster->status = Movable_Status_None;
        pMonster->sprite = sprite;
        ++sprite;
        ++pMonster;
        ++i;
    }
    return pStage;
}


void StartMonsters(ptr<Movable> pMonster, byte count, ptr<byte> pStage)
{
    byte i, b;

    ++pStage;
    do {
        b = *pStage;
        ++pStage;
        if ((pMonster->status & Movable_Status_Live) != 0) {
            pMonster->x = MovableX(b);
            pMonster->y = MovableY(b);
        }
        ++pMonster;
        --count;
    } while (count != 0);
}


void HitMonsterInArray(ptr<Movable> pMonster, byte count, ptr<Movable> pRock)
{
    do {
        if ((pMonster->status & Movable_Status_Live) != 0) {
            if (pMonster->y > pRock->y && IsNear(pMonster, pRock)) {
                pMonster->status &= ~Movable_Status_Live;
                HideSprite(pMonster->sprite);
                OnHitRock(pRock, pMonster);
            }
        }
        ++pMonster;
        --count;
    } while (count  != 0);
}


bool AdjacentOtherInArray(
    ptr<Movable> pMonster, byte count, 
    byte sprite, byte x, byte y
)
{
    do {
        if ((pMonster->status & Movable_Status_Live) != 0) {
            if (pMonster->sprite != sprite) {
                if (IsNearXY(pMonster, x, y)) {
                    return true;
                }
                // // if ((pMonster->status & Movable_Status_CanMove) != 0) {
                //     // if (
                //     //     pMonster->x + (pMonster->dx << MapShift) == x &&
                //     //     pMonster->y + (pMonster->dy << MapShift) == y
                //     // ) return true;
                //     if (IsNearXYXY(
                //         pMonster->x + (pMonster->dx << MapShift),
                //         pMonster->y + (pMonster->dy << MapShift),
                //         x, y
                //     )) return true;
                // // }
            }
        }
        ++pMonster;
        --count;
    } while (count  != 0);
    return false;
}


bool AdjacentOther(ptr<Movable> pMonster)
{
    ptr<Movable> pOther;
    byte x, y, sprite;
    if ((pMonster->status & Movable_Status_CanMove) == 0) return false;

    x = pMonster->x + pMonster->dx;
    y = pMonster->y + pMonster->dy;
    sprite = pMonster->sprite;
    return 
        AdjacentChaser(sprite, x, y) || 
        AdjacentGhost(sprite, x, y) || 
        AdjacentRock(sprite, x, y);
}


void CatchMan(ptr<Movable> pMonster)
{
    if (IsOnGrid(pMonster) && IsVeryNear(pMonster, &man)) {
        man.status &= ~Movable_Status_Live;
    }
}