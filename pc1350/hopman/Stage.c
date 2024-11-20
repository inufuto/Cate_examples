#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Status.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Goal.h"
#include "Lift.h"
#include "Monster.h"
#include "VVram.h"

extern void _deb();

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[ColumnCount / ColumnsPerByte * FloorCount] CellMap;
byte LeftX;
bool Cleared;

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
}


void InitTrying()
{
    {
        byte i;
        StageTime = 18;
        i = pStage->itemCount;
        do {
            StageTime += 8;
            --i;
        } while (i != 0);
    }
    ItemCount = pStage->itemCount;
    HideAllSprites();
    ClearScreen();
    PrintStatus();

    CopyMemory(CellMap, pStageBytes, ColumnCount / ColumnsPerByte * FloorCount);
    LeftX = 0;
    Cleared = false;
    InitMan();
    InitLifts();
    InitMonsters();
    BackgroundChanged = true;
    DrawAll();
}


void Scroll()
{
    byte newLeft;

    if (Man._.x < VVramWidth / 2 - 1) {
        newLeft = 0;
    }
    else {
        newLeft = Man._.x - (VVramWidth / 2 - 1);
        if (newLeft >= StageWidth - VVramWidth) {
            newLeft = StageWidth - VVramWidth;
        }
    }
    if (newLeft != LeftX) {
        LeftX = newLeft;
        BackgroundChanged = true;
    }
}


byte GetCell(byte column, byte floor)
{
    ptr<byte> pCell;
    if (floor >= FloorCount) return Cell_Space;
    pCell = CellMapPtr(column, floor);
    column <<= 1;
    return (*pCell >> (column & 6)) & Cell_Mask;
}


void SetCell(byte column, byte floor, byte cell)
{
    ptr<byte> pCell;
    byte shift, b;
    pCell = CellMapPtr(column, floor);
    b = *pCell;
    shift = (column << 1) & 6;
    b &= ~(0x03 << shift);
    b |= (cell << shift);
    *pCell = b;
    BackgroundChanged = true;
}


byte XToColumn(byte x)
{
    return x >> ColumnShift;
}


byte YToFloor(byte y)
{
    if (y < StageTop) return 0;
    return (y - StageTop) >> FloorShift;
}


byte FloorToY(byte floor)
{
    return (floor << FloorShift) + StageTop;
}


byte ColumnToX(byte column)
{
    return column << ColumnShift;
}