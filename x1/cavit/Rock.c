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
constexpr byte Rock_Status_Falling = 0x80;

Movable[MaxMovableCount] Rocks;


static ptr<byte> MapP(ptr<Movable> pRock)
{
    return TerrainMapPtr(pRock->x >> 1, pRock->y >> 1);
}

static void DrawFixed(ptr<Movable> pRock)
{
    ShowSprite(pRock, GChar_Rock);
    *MapP(pRock) |= Terrain_Rock;
}

static void EraseFixed(ptr<Movable> pRock)
{
    ptr<byte> pTerrain;
    byte terrain;
    pTerrain = MapP(pRock);
    terrain = *pTerrain & ~Terrain_Rock;
    *pTerrain = terrain;
    DrawTerrain(pRock->x >> 1, pRock->y >> 1, terrain);
}


ptr<byte> InitRocks(ptr<byte> pStage)
{
    return InitMovables(Rocks, MaxRockCount, Sprite_Rock, pStage);
}


void DrawRocks()
{
    ptr<Movable> pRock;
    for (pRock: Rocks) {
        if ((pRock->status & Movable_Status_Live) == 0) continue;
        DrawFixed(pRock);
    }
}


static void DrawFalling(ptr<Movable> pRock) 
{
    ShowSprite(pRock, GChar_Rock);
}


void _deb(){}

void TestRocks()
{
    constexpr byte Size = 2;
    ptr<Movable> pRock;
    for (pRock: Rocks) {
        byte status, below;
        status = pRock->status;
        if ((status & Movable_Status_Live) == 0) continue;
        if ((status & Rock_Status_Falling) != 0) continue;
        PollVSync();
        below = CurrentTerrain(pRock->x >> 1, (pRock->y >> 1) + 1);
        if ((below & Terrain_Mask) != Terrain_Space) continue;
        if (
            man.y - Size == pRock->y &&
            man.x - pRock->x + Size / 2 < Size
        ) continue;
        SetDirection(pRock, Direction_Down);
        pRock->status |= Rock_Status_Falling | Movable_Status_CanMove;
        // pRock->status &= ~RateMask;
        pRock->step = 0;
        EraseFixed(pRock);
        // DrawFalling(pRock);
    }
}


static bool IsNearAny(ptr<Movable> pRock, byte x, byte y)
{
    if (IsNearXY(&man, x, y)) return true;
    if (IsNearRock(pRock, x, y)) return true;
    return false;
}


void MoveRocks()
{
    constexpr byte Size = 2;
    ptr<Movable> pRock;
    for (pRock: Rocks) {
        byte status;
        status = pRock->status;
        if ((status & Movable_Status_Live) == 0) continue;
        if ((status & Rock_Status_Falling) == 0) continue;
        PollVSync();
        if (CanChangeDirection(pRock)) {
            byte x, y;
            ptr<byte> pCurrent, pBelow;
            byte current, below;
            x = pRock->x >> MapShift;
            y = pRock->y >> MapShift;
            if (y >= MapHeight - 1) goto end;
            pBelow = TerrainMapPtr(x, y + 1);
            below = *pBelow;
            if ((below & Terrain_Mask) != Terrain_Space) {
                end:
                pRock->status &= ~Rock_Status_Falling;
                DrawFixed(pRock);
                continue;
            }
            if (IsNearAny(pRock, pRock->x, pRock->y + Size)) {
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
        // if (IsOnGrid(pRock)) {
            HitChaser(pRock);
            HitGhost(pRock);
        // }
        MoveMovable(pRock);
        DrawFalling(pRock);
    }
}


bool IsNearRock(ptr<Movable> pMovable, byte x, byte y)
{
    ptr<Movable> pRock;
    for (pRock: Rocks) {
        byte status;
        status = pRock->status;
        if ((status & Movable_Status_Live) == 0) continue;
        if ((status & Rock_Status_Falling) == 0) continue;
        if (pRock != pMovable && IsNearXY(pRock, x, y)) return true;
    }
    return false;
}


void OnHitRock(ptr<Movable> pRock, ptr<Movable> pMonster)
{
    byte rate;
    rate = (pRock->status & RateMask) >> RateShift;
    if (rate < MaxRate + 1) {
        ++rate;
        pRock->status =
                (pRock->status & ~RateMask) | (rate << RateShift);
    }
    StartPoint(pMonster->x, pMonster->y, rate);
    // UpdateSprites();
    DrawAll();
    Sound_Hit();
}


bool AdjacentRock(ptr<Movable> pMovable, byte x, byte y)
{
    AdjacentOtherInArray(Rocks, MaxMovableCount, pMovable, x, y);
}