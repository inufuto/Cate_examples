#include "Rock.h"
#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Direction.h"
#include "Man.h"
#include "Point.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Sound.h"
#include "Main.h"

constexpr byte MaxMovableCount = Sprite_Point - Sprite_Rock;
// constexpr byte Color = 14;
constexpr byte RateShift = 4;
constexpr byte MaxRate = 3;
constexpr byte RateMask = 0x30;

Fixed[MaxRockCount] FixedRocks;
Movable[MaxMovableCount] FallingRocks;


static ptr<byte> MapP(ptr<Fixed> pFixedRock)
{
    return TerrainMapPtr(pFixedRock->x >> 1, pFixedRock->y >> 1);
}

static void DrawFixed(ptr<Fixed> pFixedRock)
{
    Put4C(pFixedRock->x, pFixedRock->y, Char_Rock);
    *MapP(pFixedRock) |= Terrain_Rock;
}

static void EraseFixed(ptr<Fixed> pFixedRock)
{
    ptr<byte> pTerrain;
    byte terrain;
    pTerrain = MapP(pFixedRock);
    terrain = *pTerrain & ~Terrain_Rock;
    *pTerrain = terrain;
    DrawTerrain(pFixedRock->x >> 1, pFixedRock->y >> 1, terrain);
}


ptr<byte> InitRocks(ptr<byte> pStage)
{
    ptr<Movable> pFallingRock;
    byte sprite;
    sprite = Sprite_Rock;
    for (pFallingRock: FallingRocks) {
        pFallingRock->status = 0;
        pFallingRock->sprite = sprite;
        SetDirection(pFallingRock, Direction_Down);
        ++sprite;
    }
    return InitFixeds(FixedRocks, MaxRockCount, pStage);
}


void DrawRocks()
{
    ptr<Fixed> pFixedRock;
    for (pFixedRock: FixedRocks) {
        if ((pFixedRock->status & Fixed_Status_Exist) == 0) continue;
        DrawFixed(pFixedRock);
    }
}

static void DrawFalling(ptr<Movable> pFallingRock) 
{
    ShowSpriteC(pFallingRock, Char_Rock);
}

static bool BeginFalling(byte x, byte y)
{
    ptr<Movable> pFallingRock;
    for (pFallingRock: FallingRocks) {
        if ((pFallingRock->status & Movable_Status_Live) != 0) continue;
        pFallingRock->x = x;    // << CoordShift;
        pFallingRock->y = y;    // << CoordShift;
        pFallingRock->status = Movable_Status_Live | Movable_Status_CanMove;
        pFallingRock->step = 0;
        DrawFalling(pFallingRock);
        return true;
    }
    return false;
}


void TestRocks()
{
    constexpr byte Size = 2;
    ptr<Fixed> pFixedRock;
    for (pFixedRock: FixedRocks) {
        byte below;
        if ((pFixedRock->status & Fixed_Status_Exist) == 0) continue;
        below = CurrentTerrain(pFixedRock->x >> 1, (pFixedRock->y >> 1) + 1);
        if ((below & Terrain_Mask) != Terrain_Space) continue;
        if (
            man.y - Size == pFixedRock->y &&
            man.x - pFixedRock->x + Size / 2 < Size
        ) continue;
        if (BeginFalling(pFixedRock->x, pFixedRock->y)) {
            pFixedRock->status &= ~Fixed_Status_Exist;
            EraseFixed(pFixedRock);
        }
    }
}


static void EndFalling(byte x, byte y)
{
    ptr<Fixed> pFixedRock;
    for (pFixedRock: FixedRocks) {
        if ((pFixedRock->status & Fixed_Status_Exist) != 0) continue;
        pFixedRock->status |= Fixed_Status_Exist;
        pFixedRock->x = x;
        pFixedRock->y = y;
        DrawFixed(pFixedRock);
        return;
    }
}


static bool IsNearAny(ptr<Movable> pFallingRock, byte x, byte y)
{
    if (IsNearXY(&man, x, y)) return true;
    if (IsNearRock(pFallingRock, x, y)) return true;
    return false;
}


void MoveRocks()
{
    constexpr byte Size = 2;
    ptr<Movable> pFallingRock;
    for (pFallingRock: FallingRocks) {
        if ((pFallingRock->status & Movable_Status_Live) == 0) continue;
        if (CanChangeDirection(pFallingRock)) {
            byte x, y;
            ptr<byte> pCurrent, pBelow;
            byte current, below;
            x = pFallingRock->x >> MapShift;
            y = pFallingRock->y >> MapShift;
            if (y >= MapHeight - 1) goto end;
            pBelow = TerrainMapPtr(x, y + 1);
            below = *pBelow;
            if ((below & Terrain_Mask) != Terrain_Space) {
                end:
                pFallingRock->status &= ~Movable_Status_Live;
                HideSprite(pFallingRock->sprite);
                EndFalling(pFallingRock->x, pFallingRock->y);
                continue;
            }
            if (IsNearAny(pFallingRock, pFallingRock->x, pFallingRock->y + Size)) {
                continue;
            }
            pCurrent = TerrainMapPtr(x, y);
            current = *pCurrent & ~Wall_Bottom;
            *pCurrent = current;
            DrawTerrain(x, y, current);
            below &= ~Wall_Top;
            *pBelow = below;
            DrawTerrain(x, y + 1, below);
        }
        // if (IsOnGrid(pFallingRock)) {
            HitChaser(pFallingRock);
            HitGhost(pFallingRock);
        // }
        MoveMovable(pFallingRock);
        DrawFalling(pFallingRock);
    }
}


bool IsNearRock(ptr<Movable> pMovable, byte x, byte y)
{
    ptr<Movable> pFallingRock;
    for (pFallingRock: FallingRocks) {
        if ((pFallingRock->status & Movable_Status_Live) == 0) continue;
        if (pFallingRock != pMovable && IsNearXY(pFallingRock, x, y)) return true;
    }
    return false;
}


void OnHitRock(ptr<Movable> pFallingRock, ptr<Movable> pMonster)
{
    byte rate;
    rate = pFallingRock->status >> RateShift;
    if (rate < MaxRate + 1) {
        ++rate;
        pFallingRock->status =
                (pFallingRock->status & ~RateMask) | (rate << RateShift);
    }
    StartPoint(pMonster->x, pMonster->y, rate);
    // UpdateSprites();
    DrawAll();
    Sound_Hit();
}


bool AdjacentRock(ptr<Movable> pMovable, byte x, byte y)
{
    AdjacentOtherInArray(FallingRocks, MaxMovableCount, pMovable, x, y);
}