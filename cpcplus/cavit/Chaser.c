#include "Chaser.h"
#include "Sprite.h"
#include "Stage.h"
#include "Man.h"
#include "Direction.h"
#include "Chars.h"

constexpr byte MaxCount = Sprite_Rock - Sprite_Chaser;
Movable[MaxCount] Chasers;
static ptr<byte> pChaserPositions;

ptr<byte> InitChasers(ptr<byte> pStage)
{
    pChaserPositions = pStage;
    return InitMonsters(Chasers, MaxCount, Sprite_Chaser, pStage);
}


static void Draw(ptr<Movable> pChaser)
{
    ShowSprite(pChaser, Pattern_Chaser);
}


static bool CanMove(ptr<Movable> pChaser, byte direction)
{
    byte mapX, mapY;
    byte current, next;
    SetDirection(pChaser, direction);
    mapX = pChaser->x >> MapShift;
    mapY = pChaser->y >> MapShift;
    current = CurrentTerrain(mapX, mapY);
    if ((current & WallBits[direction >> 1]) != 0) return false;
    mapX += pChaser->dx;
    mapY += pChaser->dy;
    next = CurrentTerrain(mapX, mapY);
    return (next & Terrain_Mask) == Terrain_Space && !AdjacentOther(pChaser);
}

static void DecideDirection(ptr<Movable> pChaser)
{
    byte direction;
    if (man.x != pChaser->x) {
        if (man.x >= pChaser->x) {
            direction = Direction_Right;
        }
        else {
            direction = Direction_Left;
        }
        if (CanMove(pChaser, direction)) goto can;
    }
    if (man.y != pChaser->y) {
        if (man.y >= pChaser->y) {
            direction = Direction_Down;
        }
        else {
            direction = Direction_Up;
        }
        if (CanMove(pChaser, direction)) goto can;
    }
    pChaser->status &= ~Movable_Status_CanMove;
    return;

    can:
    pChaser->status |= Movable_Status_CanMove;
}


void StartChasers()
{
    StartMonsters(Chasers, MaxCount, pChaserPositions);
    {
        ptr<Movable> pChaser;
        for (pChaser: Chasers) {
            if ((pChaser->status & Movable_Status_Live) == 0) continue;
            DecideDirection(pChaser);
            Draw(pChaser);
        }
    }
}


void MoveChasers()
{
    ptr<Movable> pChaser;
    for (pChaser: Chasers) {
        if ((pChaser->status & Movable_Status_Live) == 0) continue;
        CatchMan(pChaser);
        if (
            (pChaser->dx | pChaser->dy) == 0 ||
            CanChangeDirection(pChaser)
        ) {
            DecideDirection(pChaser);
        }
        if (AdjacentOther(pChaser)) {
            pChaser->dx = 0;
            pChaser->dy = 0;
            continue;
        }
        if (MoveMovable(pChaser)) {
            Draw(pChaser);
            CatchMan(pChaser);
        }
    }
}


void HitChaser(ptr<Movable> pMovable)
{
    HitMonsterInArray(Chasers, MaxCount, pMovable);
}


bool AdjacentChaser(byte sprite, byte x, byte y)
{
    return AdjacentOtherInArray(Chasers, MaxCount, sprite, x, y);
}