#include "Rock.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Direction.h"
#include "Man.h"
#include "Point.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Sound.h"

constexpr byte RateShift = 4;
constexpr byte MaxRate = 3;
constexpr byte RateMask = 0x30;

Fixed[MaxRockCount] FixedRocks;
Movable[MaxRockCount] FallingRocks;

static ptr<byte> MapP(ptr<Fixed> pFixedRock)
{
    return TerrainMapPtr(pFixedRock->x >> 1, pFixedRock->y >> 1);
}

static void DrawFixed(ptr<Fixed> pFixedRock)
{
    ShowSprite(pFixedRock->sprite, pFixedRock->x << CoordShift, pFixedRock->y << CoordShift, Pattern_Rock);
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
        SetDirection(pFallingRock, Direction_Down);
        ++sprite;
    }
    return InitFixeds(FixedRocks, Sprite_Rock, MaxRockCount, pStage);
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
    ShowSprite(pFallingRock->sprite, pFallingRock->x, pFallingRock->y, Pattern_Rock);
}

static void BeginFalling(ptr<Fixed> pFixedRock)
{
    ptr<Movable> pFallingRock;
    pFallingRock = FallingRocks + (pFixedRock->sprite - Sprite_Rock);
    pFallingRock->x = pFixedRock->x << CoordShift;
    pFallingRock->y = pFixedRock->y << CoordShift;
    pFallingRock->sprite = pFixedRock->sprite;
    pFallingRock->status = Movable_Status_Live | Movable_Status_CanMove;
    // pFallingRock->step = 0;
    DrawFalling(pFallingRock);
    pFixedRock->status &= ~Fixed_Status_Exist;
    EraseFixed(pFixedRock);
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
            (man.y >> CoordShift) - Size == pFixedRock->y &&
            (man.x >> CoordShift) - pFixedRock->x + Size / 2 < Size
        ) continue;
        BeginFalling(pFixedRock);
    }
}


static void EndFalling(ptr<Movable> pFallingRock)
{
    ptr<Fixed> pFixedRock;
    pFixedRock = FixedRocks + (pFallingRock->sprite - Sprite_Rock);
    pFixedRock->status |= Fixed_Status_Exist;
    pFixedRock->x = pFallingRock->x >> CoordShift;
    pFixedRock->y = pFallingRock->y >> CoordShift;
    HideSprite(pFallingRock->sprite);
    DrawFixed(pFixedRock);
}


static bool IsNearAny(ptr<Movable> pFallingRock, byte x, byte y)
{
    if (IsNearXY(&man, x, y)) return true;
    if (IsNearRock(pFallingRock, x, y)) return true;
    return false;
}


void MoveRocks()
{
    constexpr byte Size = 2 << CoordShift;
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
                EndFalling(pFallingRock);
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
        if (IsOnGrid(pFallingRock)) {
            HitChaser(pFallingRock);
            HitGhost(pFallingRock);
        }
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
    Sound_Hit();
}


bool AdjacentRock(byte sprite, byte x, byte y)
{
    return AdjacentOtherInArray(FallingRocks, MaxRockCount, sprite, x, y);
}