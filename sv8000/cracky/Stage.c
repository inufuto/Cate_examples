#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Status.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Destruction.h"

extern void _deb();

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[ColumnCount / ColumnsPerByte * FloorCount] CellMap;

void InitStage() 
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


void InitTrying()
{
    {
        byte i;
        StageTime = 25;
        i = pStage->itemCount;
        do {
            StageTime += 5;
            --i;
        } while (i != 0);
    }
    ItemCount = pStage->itemCount;
    HideAllSprites();
    ClearScreen();
    PrintStatus();

    CopyMemory(CellMap, pStageBytes, ColumnCount / ColumnsPerByte * FloorCount);
    {
        ptr<byte> pByte = pStageBytes;
        word vram = Vram + VramRowSize * StageTop;
        byte y = StageTop;
        repeat (FloorCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte b = *pByte; ++pByte;
                repeat (ColumnsPerByte) {
                    vram = DrawCell(vram, b, y);
                    b >>= (8 / ColumnsPerByte);
                }
            }
            vram += VramRowSize * FloorHeight - StageWidth;
            y += FloorHeight;
        }
    }
    InitMan();
    InitMonsters();
    InitDestructions();
    // UpdateSprites();
    DrawAll();
}


byte GetCell(byte column, byte floor)
{
    byte b;
    b = *CellMapPtr(column, floor);
    if ((column & 1) == 0) {
        return b & 0x0f;
    }
    else {
        return b >> 4;
    }
}


void SetCell(byte column, byte floor, byte cell)
{
    ptr<byte> pCell;
    byte mask;
    pCell = CellMapPtr(column, floor);
    if ((column & 1) == 0) {
        mask = 0xf0;
        cell &= 0x0f;
    }
    else {
        mask = 0x0f;
        cell <<= 4;
    }
    *pCell = (*pCell & mask) | cell;
}


void DrawCellXY(byte x, byte y)
{
    y -= StageTop;
    byte xCount = (x & ColumnMask) == 0 ? 1 : 2;
    byte yCount = (y & FloorMask) == 0 ? 1 : 2;
    byte leftColumn = x >> ColumnShift;
    byte floor = y >> FloorShift;
    byte leftX = leftColumn << ColumnShift;
    byte cellY = (floor << FloorShift) + StageTop;
    word leftVram = VramAddress(leftX, cellY);
    do {
        byte column = leftColumn;
        byte cellX = leftX;
        word vram = leftVram;
        byte i = xCount;
        do {
            byte b = GetCell(column, floor);
            vram = DrawCell(vram, b, cellY);
            ++column;
            --i;
        } while (i != 0);
        leftVram += VramRowSize * FloorHeight;
        cellY += FloorHeight;
        ++floor;
        --yCount;
    } while (yCount != 0);
}