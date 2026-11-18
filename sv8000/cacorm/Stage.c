#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Movable.h"
#include "Actor.h"
#include "Sprite.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Status.h"
#include "Man.h"
#include "Item.h"
#include "Monster.h"
#include "Point.h"
#include "Increaser.h"
#include "Line.h"

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[MapWidth * MapHeight] CellMap;

void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
            }
        }
        pStage = p;
        pStageBytes = pStage->bytes;
    }
    InitItems();
    InitMonsters();
}


void InitTrying()
{
    {
        byte i;
        StageTime = 60;
        i = pStage->enemyCount;
        do {
            StageTime += 30;
            --i;
        } while (i != 0);
    }
    HideAllSprites();
    // UpdateSprites();
    ClearScreen();
    PrintStatus();
    LineCharOffset = 0;
    {
        word vram = Vram + VramRowSize * StageTop;
        ptr<byte> pCell = CellMap;
        ptr<byte> pByte = pStageBytes;
        repeat (MapHeight) {
            repeat (MapWidth / 8) {
                byte b = *pByte;
                ++pByte;
                repeat (8) {
                    byte cell;
                    if ((b & 1) != 0) {
                        cell = Cell_Wall;
                    }
                    else {
                        cell = Cell_Space;
                    }
                    *pCell = cell;
                    ++pCell;
                    vram = DrawCell(vram, cell);
                    b >>= 1;
                }
            }
            vram += VramRowSize * CellSize - MapWidth * CellSize;
        }
    }
    InitMan();
    DrawItems();
    StartMonsters();
    InitPoints();
    InitIncreaser();
    DrawAll();
}


ptr<byte> CellMapPtr(byte x, byte y)
{
    return CellMap + ((y << 4) + x);
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) return Cell_Wall;
    return *CellMapPtr(x, y);
}


void SetCell(byte x, byte y, byte cell)
{
    *CellMapPtr(x, y) = cell;
    word vram = VramAddress(x << 1, (y << 1) + StageTop);
    DrawCell(vram, cell);
}


word DrawCell(word vram, byte cell)
{
    if (cell == 0) {
        repeat (2) {
            repeat (2) {
                vram = VAdd(vram, Char_Space);
            }
            vram += VramRowSize - CellSize;
        }
    }
    else if ((cell & Cell_Mask) == 0) {
        return DrawLineCell(vram, cell);
    }
    else {
        byte c = (cell & Cell_Mask) == Cell_Item ? Char_Item : Char_Block;
        repeat (2) {
            repeat (2) {
                vram = VAdd(vram, c);
                ++c;
            }
            vram += VramRowSize - CellSize;
        }
    }
    return vram - VramRowSize * CellSize + CellSize;
}

void DrawCellXY(byte x, byte y)
{
    byte xCount = (x & CellMask) + 1;
    byte yCount = (y & CellMask) + 1;
    byte leftCellX = x >> CellShift;
    byte cellY = (y - StageTop) >> CellShift;
    do {
        byte cellX = leftCellX;
        byte count = xCount;
        do {
            DrawCell(VramAddress(cellX << 1, (cellY << 1) + StageTop), GetCell(cellX, cellY));
            ++cellX;
            --count;
        } while (count != 0);
        ++cellY;
        --yCount;
    } while (yCount != 0);
}