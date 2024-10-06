#include "Vram.h"
#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Chars.h"
#include "Status.h"
#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fire.h"
#include "Monster.h"
#include "Block.h"
#include "Math.h"
#include "VVram.h"

constexpr byte VisibleFloorCount = (VVramHeight + FloorHeight - 1) / FloorHeight + 1;
constexpr byte MapWidth = ColumnCount / 4;

ptr<Stage> pStage;
byte[MapWidth * MaxMapHeight] StageMap;
static byte timeRate;

byte topY, topRow, yMod, topYRange;
byte dotOffset;
byte[VVramWidth * VisibleFloorCount * FloorHeight] Background;

extern void _deb();
void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        timeRate = 10;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
                if (timeRate != 0) {
                    --timeRate;
                }
            }
        }
        pStage = p;
    }
    {
        ptr<byte> pBytes, pMap;
        byte yCount, xCount, b, d, spaceCount, shiftCount;
        yCount = pStage->height;
        pBytes = pStage->pBytes;
        pMap = StageMap;
        d = 0;
        shiftCount = 0;
        xCount = ColumnCount;
        do {
            b = *pBytes; ++pBytes;
            spaceCount = b >> 2;
            while (spaceCount != 0) {
                d >>= 2;
                ++shiftCount;
                if (shiftCount >= 4) {
                    *pMap = d; ++pMap;
                    d = 0;
                    shiftCount = 0;
                }
                --spaceCount;
                --xCount;
            }
            d >>= 2;
            d |= (b & CellType_Mask) << 6;
            ++shiftCount;
            if (shiftCount >= 4) {
                *pMap = d; ++pMap;
                d = 0;
                shiftCount = 0;
            }
            --xCount;
            if (xCount == 0) {
                --yCount;
                xCount = ColumnCount;
            }
        } while (yCount != 0);
    }
}


void InitTrying()
{
    byte i;
    StageTime = 100;
    i = pStage->height;
    do {
        StageTime += timeRate;
        --i;
    } while (i != 0);

    HideAllSprites();
    ClearScreen();
    PrintStatus();
    topY = (pStage->height << 2) + FloorHeight - VVramHeight;
    topYRange = topY + 1;
    topRow = 0x80;
    dotOffset = 0;
    RndIndex = 0;
    InitBlocks();
    InitMan();
    InitFires();
    InitMonsters();

    DrawBackground();
    SwitchStatus(1);
    DrawAll();
}


void DrawBackground()
{
    byte newTopRow;
    yMod = topY;
    newTopRow = -1;
    while (yMod >= FloorHeight) {
        ++newTopRow;
        yMod -= FloorHeight;
    }
    if (newTopRow != topRow) {
        topRow = newTopRow;
    }
    BackgroundChanged = true;
}


byte GetCellType(byte x, byte y)
{
    byte row, offset, b;
    row = (y >> FloorShift) - 1;
    if (row >= pStage->height) return 0;
    x >>= 1;
    offset = ((row << 1) + row) + (x >> 2);
    b = StageMap[offset];
    x &= 0x03;
    while (x != 0) {
        b >>= 2;
        --x;
    }
    return b & CellType_Mask;
}


bool IsOnFloor(byte y)
{
    return ((y - Overhead) & FloorMask) == 0;
}


bool IsWall(byte x, byte y)
{
    if ((x & 1) != 0) return false;
    return GetCellType(x, y) == CellType_Wall;
}


byte ToX(byte b)
{
    return (b & 0x0f) << 1;
}


byte ToY(byte b)
{
    byte y;
    y = (b & 0xf0) >> 2;
    return y + (Overhead + FloorHeight);
}
