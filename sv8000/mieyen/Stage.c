#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Math.h"
#include "Sprite.h"
#include "Status.h"
#include "Chars.h"
#include "Vram.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Point.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount / ColumnsPerByte * RowCount] CellMap;

void InitStage()
{
    {
        FireTime = RowHeight * RowCount;
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
    RndIndex = 0;
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    CopyMemory(CellMap, pStage->bytes, ColumnCount / ColumnsPerByte * RowCount);
    {
        {
            word vram = Vram + VramRowSize * StageTop;
            repeat (ColumnWidth * ColumnCount + 1) {
                vram = Put(vram, Char_Wall);
            }
            ptr<byte> pCell = CellMap;
            vram += VramRowSize - (ColumnWidth * ColumnCount + 1);
            repeat (RowCount) {
                Put(vram, Char_Wall);
                Put(vram + VramRowSize, Char_Wall);
                Put(vram + VramRowSize * 2, Char_Wall);
                ++vram;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_BottomWall) != 0) {
                            Put(vram + VramRowSize * 2, Char_Wall);
                            Put(vram + VramRowSize * 2 + 1, Char_Wall);
                        }
                        vram += 2;
                        if ((cell & Cell_RightWall) != 0) {
                            Put(vram, Char_Wall);
                            Put(vram + VramRowSize, Char_Wall);
                        }
                        Put(vram + VramRowSize * 2, Char_Wall);
                        ++vram;
                        cell >>= 4;
                    }
                }
                vram += VramRowSize * RowHeight - (ColumnWidth * ColumnCount + 1);
            }
        }
        {
            FoodCount = 0;
            word vram = Vram + VramRowSize * (StageTop + 1) + 1;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            ++FoodCount;
                        }
                        DrawCell(vram, cell);
                        vram += ColumnWidth;
                        cell >>= 4;
                    }
                }
                vram += VramRowSize * RowHeight - ColumnWidth * ColumnCount;
            }
            PrintFoodCount();
        }
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
    word vram = VramAddress(ToCoord(column), ToCoord(row) + StageTop);
    DrawCell(vram, cell);
}

void DrawCell(word vram, byte cell)
{
    if ((cell & Cell_Dot) != 0) {
        Put2CQ(vram, Char_Dot);
    }
    else if ((cell & Cell_Food) != 0) {
        Put2CQ(vram, Char_Food);
    }
    else {
        Erase2Q(vram);
    }
}


byte CoordMod(byte a)
{
    static const byte[] Mods = {
        2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0
    };
    return Mods[a >> CoordShift];
}

byte ToGrid(byte a)
{
    static const byte[] Grids = {
        -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10
    };
    return Grids[a >> CoordShift];
}


byte ToCoord(byte a)
{
    return 1 + (a << 1) + a;
}


void DrawCellXY(byte x, byte y)
{
    byte column = ToGrid(x);
    byte row = ToGrid(y);
    word vram = VramAddress(ToCoord(column), ToCoord(row) + StageTop);
    switch (CoordMod(y)) {
        case 0:
            switch (CoordMod(x)) {
                case 0: 
                    DrawCell(vram, GetCell(column, row));
                    break;
                case 1:
                    DrawCell(vram, GetCell(column, row));
                    vram += ColumnWidth - 1;
                    VAdd(vram, Char_Space);
                    VAdd(vram + VramRowSize, Char_Space);
                    break;
                case 2:
                    vram += ColumnWidth - 1;
                    VAdd(vram, Char_Space);
                    VAdd(vram + VramRowSize, Char_Space);
                    ++vram;
                    DrawCell(vram, GetCell(column + 1, row));
                    break;
            }
            break;
        case 1:
            DrawCell(vram, GetCell(column, row));
            vram += VramRowSize * (RowHeight - 1);
            VAdd(vram, Char_Space);
            VAdd(vram + 1, Char_Space);
            break;
        case 2:
            vram += VramRowSize * (RowHeight - 1);
            VAdd(vram, Char_Space);
            VAdd(vram + 1, Char_Space);
            vram += VramRowSize;
            DrawCell(vram, GetCell(column, row + 1));
            break;
    }
}