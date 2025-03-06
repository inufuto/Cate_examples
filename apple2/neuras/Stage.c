#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Vram.h"
#include "Solver.h"
#include "Card.h"
#include "Monster.h"
#include "Sprite.h"

constexpr byte MapWidth = StageWidth / 8;

byte CurrentStage;
byte[MapWidth * StageHeight] WallMap;
word StageTime;

static ptr<Stage> StagePointer()
{
    byte index;
    ptr<Stage> p;
    index = CurrentStage;
    while (index >= StageCount) {
        index -= StageCount;
    }
    p = Stages;
    while (index != 0) {
        ++p;
        --index;
    }
    return p;
}


void InitStage()
{
    ptr<Stage> pStage;
    ptr<byte> pByte, pMap;
    byte b, bit;
    byte wall, wallBit;

    pMap = WallMap;
    // top row
    repeat(MapWidth - 1)
    {
        *pMap = 0xff;
        ++pMap;
    }
    *pMap = 0x7f;
    ++pMap;

    pStage = StagePointer();
    pByte = pStage->bytes;
    b = *pByte;
    ++pByte;
    bit = 1;
    repeat(7)
    {
        // vertical walls
        wall = 1;
        wallBit = 2;
        repeat((StageWidth - 2) / 3)
        {
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            if ((b & bit) != 0)
            {
                wall |= wallBit;
            }
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            if ((bit <<= 1) == 0)
            {
                b = *pByte;
                ++pByte;
                bit = 1;
            }
        }

        *pMap = wall;
        ++pMap;
        // vertical walls(copy of upper row)
        repeat(MapWidth)
        {
            *pMap = pMap[-MapWidth];
            ++pMap;
        }

        // horizontal walls
        wall = 1;
        wallBit = 2;
        repeat((StageWidth - 2) / 3)
        {
            if ((b & bit) != 0)
            {
                wall |= wallBit;
            }
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            if ((b & bit) != 0)
            {
                wall |= wallBit;
            }
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            wall |= wallBit;
            if ((wallBit <<= 1) == 0)
            {
                *pMap = wall;
                ++pMap;
                wall = 0;
                wallBit = 1;
            }
            if ((bit <<= 1) == 0)
            {
                b = *pByte;
                ++pByte;
                bit = 1;
            }
        }
        *pMap = wall;
        ++pMap;
    }

    MapToVVram();
    InitCards(pStage->cardPositions, pStage->cardCount);
}

static byte FromPosition(byte a)
{
    return (a + a + a + 1) << 3;
}

void InitTrying()
{
    ptr<Stage> pStage;
    
    pStage = StagePointer();
    {
        byte x, y;
        x = FromPosition(pStage->startPosition >> 4);
        y = FromPosition(pStage->startPosition & 0x0f);
        InitSolver(x, y);
    }
    {
        sword cardCount, t;
        cardCount = pStage->cardCount;
        t = cardCount << 4;
        t -= (CurrentStage >> 2);
        if (t < 0) t = 0;
        t += 60;
        StageTime = t;
    }

    InitMonsters(pStage->monsterPositions, pStage->monsterCount);
    VVramBackToFront();
    DrawSprites();
}

bool TestMap2(byte x, byte y)
{
    byte left, top, width, height;
    ptr<byte> pMap;
    word mask;
    byte maskLow, maskHigh;

    left = x >> 3;
    width = ((x + 23) >> 3) - left;
    top = y >> 3;
    height = ((y + 23) >> 3) - top;

    pMap = WallMap + (top << 2) + (left >> 3);
    mask = (word)(width > 2 ? 7 : 3);
    mask <<= (left & 7);
    maskLow = mask;
    maskHigh = mask >> 8;

    {
        byte c;
        c = height;
        while (c != 0)
        {
            if ((pMap[0] & maskLow) != 0 || (pMap[1] & maskHigh) != 0)
            {
                return false;
            }
            pMap += 4;
            --c;
        }
    }
    return true;
}