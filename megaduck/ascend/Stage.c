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

constexpr byte VisibleFloorCount = (WindowHeight + FloorHeight - 1) / FloorHeight + 1;
constexpr byte MapWidth = ColumnCount / 4;

ptr<Stage> pStage;
byte[MapWidth * MaxMapHeight] StageMap;
static byte timeRate;

byte topY, topRow, yMod, topYRange;
byte dotOffset;

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
    UpdateSprites();
    ClearScreen();
    PrintStatus();
    topY = (pStage->height << 2) + FloorHeight - WindowHeight;
    topYRange = topY + 1;
    topRow = 0x80;
    dotOffset = 0;
    RndIndex = 0;
    InitMan();
    InitFires();
    InitMonsters();
    InitBlocks();
    DrawBackground();
    UpdateOffset();
    UpdateSprites();
}


static ptr<byte> Repeat(ptr<byte> pVram, byte left, byte right, byte count)
{
    do {
        pVram = WriteVram(pVram, left); 
        pVram = WriteVram(pVram, right); 
        pVram += VramRowSize - 2 * VramStep;
        --count;
    } while (count != 0);
    return pVram;
}

void FillBackground()
{
    ptr<byte> pMap, pMapL, pVram;
    byte row;
    if ((topRow & 0x80) != 0) {
        pMap = StageMap;
    }
    else {
        pMap = StageMap + (topRow << 1) + topRow;
    }
    pVram = pNextPage + VramRowSize * StatusHeight;
    row = topRow;
    repeat (VisibleFloorCount) {
        pMapL = pMap + MapWidth;
        repeat (MapWidth) {
            byte middle, lower;
            if ((row & 0x80) != 0) {
                middle = 0;
                lower = *pMap;
            }
            else {
                middle = *pMap; 
                lower = row + 1 < pStage->height ? *pMapL : CellType_Space;
            }
            ++pMap; ++pMapL;
            repeat (4) {
                switch (middle & 3) {
                case CellType_Space:
                    pVram = Repeat(pVram, Char_Space, Char_Space, 1);
                    switch (lower & 3) {
                    case CellType_Ladder:
                        pVram = Repeat(pVram, Char_Ladder_Left, Char_Ladder_Right, 3);
                        break;
                    case CellType_Wall:
                        pVram = Repeat(pVram, Char_Space, Char_Space, 2);
                        pVram = Repeat(pVram, Char_Wall, Char_Floor, 1);
                        break;
                    default:
                        pVram = Repeat(pVram, Char_Space, Char_Space, 2);
                        pVram = Repeat(pVram, Char_Floor, Char_Floor, 1);
                    }
                    break;
                case CellType_Ladder:
                    pVram = Repeat(pVram, Char_Ladder_Left, Char_Ladder_Right, 3);
                    switch (lower & 3) {
                    case CellType_Ladder:
                        pVram = Repeat(pVram, Char_Ladder_Left, Char_Ladder_Right, 1);
                        break;
                    case CellType_Wall:
                        pVram = Repeat(pVram, Char_Wall, Char_Floor, 1);
                        break;
                    default:
                        pVram = Repeat(pVram, Char_Floor, Char_Floor, 1);
                    }
                    break;
                case CellType_Wall:
                    pVram = Repeat(pVram, Char_Wall, Char_Space, 3);
                    switch (lower & 3) {
                    case CellType_Wall:
                        pVram = Repeat(pVram, Char_Wall, Char_Floor, 1);
                        break;
                    default:
                        pVram = Repeat(pVram, Char_Floor, Char_Floor, 1);
                    }
                    break;
                default:
                    pVram = Repeat(pVram, Char_Space, Char_Space, 4);
                }
                pVram += ColumnWidth * VramStep - VramRowSize * FloorHeight;
                middle >>= 2;
                lower >>= 2;
            }
        }
        if ((row & 0x80) != 0) {
            pMap = StageMap;
        }
        pVram += VramRowSize * FloorHeight - StageWidth * VramStep;
        ++row;
    }
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
        FillBackground();
        DrawBlocks();
        SwitchPage();
    }
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
