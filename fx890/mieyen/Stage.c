#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Math.h"
#include "Sprite.h"
#include "Status.h"
#include "Chars.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Point.h"
#include "Vram.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount / ColumnsPerByte * RowCount] CellMap;

void InitStage()
{
    {
        FireTime = (RowHeight * RowCount) * 4 / 3;
        ptr<Stage> p = Stages;
        byte i = 0;
        byte j = 0;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
                --FireTime;
                if (FireTime < RowHeight * 2) {
                    FireTime = RowHeight * 2;
                }
            }
        }
        pStage = p;
    }
    InitMonsters();
}


void InitTrying()
{
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    CopyMemory(CellMap, pStage->bytes, ColumnCount / ColumnsPerByte * RowCount);
    {
        constexpr byte Wall_Left = 0x01;
        constexpr byte Wall_Right = 0x02;
        constexpr byte Wall_Top = 0x04;
        constexpr byte Wall_Bottom = 0x08;
        constexpr byte Wall_All = 0x0f;

        FoodCount = 0;
        ptr<byte> pCell = CellMap;
        ptr<byte> pVVram = VVram;
        repeat (RowCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte cell = *pCell; ++pCell;
                repeat (ColumnsPerByte) {
                    if ((cell & Cell_Food) != 0) {
                        ++FoodCount;
                    }
                    *pVVram = (cell & 0x0f) + Char_BG;
                    ++pVVram;
                    cell >>= 4;
                }
            }
        }
        PrintFoodCount();
    }
    InitMan();
    StartMonsters();
    InitFires();
    InitPoints();
    DrawAll();
}


byte GetCell(byte column, byte row)
{
    byte b = *CellMapPtr(column, row);
    if ((column & 1) != 0) {
        return b >> 4;
    }
    return b & 0x0f;
}


void SetCell(byte column, byte row, byte cell)
{
    ptr<byte> pCell = CellMapPtr(column, row);
    if ((column & 1) != 0) {
        *pCell = (*pCell & 0x0f) | (cell << 4);
    }
    else {
        *pCell = (*pCell & 0xf0) | (cell & 0x0f);
    }
    ptr<byte> pVVram = VVramPtr((column), (row));
    byte b = (*pVVram - Char_BG) & 3;
    if ((cell & Cell_Dot) != 0) {
        b |= Cell_Dot;
    }
    else if ((cell & Cell_Food) != 0) {
        b |= Cell_Food;
    }
    *pVVram = b + Char_BG;
}


byte ToGrid(byte a)
{
    return a >> (CoordShift + 1);
}


byte ToCoord(byte a)
{
    return a << 1;
}