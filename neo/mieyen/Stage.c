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

ptr<Stage> pStage;
byte[ColumnCount / ColumnsPerByte * RowCount] CellMap;

constexpr byte VVramWidth = 1 + ColumnWidth * ColumnCount;
constexpr byte VVramHeight = 1 + RowHeight * RowCount;
byte[VVramWidth * VVramHeight] VVram;

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
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    CopyMemory(CellMap, pStage->bytes, ColumnCount / ColumnsPerByte * RowCount);
    FillMemory(VVram, VVramWidth * VVramHeight, Char_Space);
    {
        constexpr byte Wall_Left = 0x01;
        constexpr byte Wall_Right = 0x02;
        constexpr byte Wall_Top = 0x04;
        constexpr byte Wall_Bottom = 0x08;
        constexpr byte Wall_All = 0x0f;
        {
            // byte y = StageTop;
            ptr<byte> pVVram = VVram;
            // byte x = 0;
            repeat (ColumnWidth * ColumnCount + 1) {
                // x = Put(x, y, Char_Wall | Wall_All);
                pVVram[0] = Char_Wall | Wall_All; ++pVVram;
            }
            ptr<byte> pCell = CellMap;
            // ++y;
            repeat (RowCount) {
                // x = 0;
                // Put(x, y, Char_Wall | Wall_All);
                pVVram[0] = Char_Wall | Wall_All;
                // Put(x, y + 1, Char_Wall | Wall_All);
                pVVram[VVramWidth] = Char_Wall | Wall_All;
                // Put(x, y + 2, Char_Wall | Wall_All);
                pVVram[VVramWidth * 2] = Char_Wall | Wall_All;
                // ++x; 
                ++pVVram;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_BottomWall) != 0) {
                            // Put(x, y + 2, Char_Wall | Wall_All);
                            pVVram[VVramWidth * 2] = Char_Wall | Wall_All;
                            // Put(x + 1, y + 2, Char_Wall | Wall_All);
                            pVVram[VVramWidth * 2 + 1] = Char_Wall | Wall_All;
                        }
                        // x += 2; 
                        pVVram += 2;
                        if ((cell & Cell_RightWall) != 0) {
                            // Put(x, y, Char_Wall | Wall_All);
                            pVVram[0] = Char_Wall | Wall_All;
                            // Put(x, y + 1, Char_Wall | Wall_All);
                            pVVram[VVramWidth] = Char_Wall | Wall_All;
                        }
                        // Put(x, y + 2, Char_Wall | Wall_All);
                        pVVram[VVramWidth * 2] = Char_Wall | Wall_All;
                        // ++x; 
                        ++pVVram;
                        cell >>= 4;
                    }
                }
                // y += 3;
                pVVram += VVramWidth * 2;
            }
        }
        {
            byte y = 0;
            ptr<byte> pVVram = VVram;
            repeat (VVramHeight) {
                byte x = 0;
                repeat (VVramWidth) {
                    byte c = pVVram[0];
                    if (x >= 1 && pVVram[-1] != Char_Space) {
                        c &= ~Wall_Left;
                    }
                    if (x < VVramWidth - 1 && pVVram[1] != Char_Space) {
                        c &= ~Wall_Right;
                    }
                    if (y >= 1 && pVVram[-VVramWidth] != Char_Space) {
                        c &= ~Wall_Top;
                    }
                    if (y < VVramHeight - 1 && pVVram[VVramWidth] != Char_Space) {
                        c &= ~Wall_Bottom;
                    }
                    x = Put(x, y + StageTop, c);
                    ++pVVram;
                }
                ++y;
            }
        }
        {
            FoodCount = 0;
            byte y = StageTop + 1;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                byte x = 1;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            Put2C(x, y, Char_Food);
                            ++FoodCount;
                        }
                        else if ((cell & Cell_Dot) != 0) {
                            Put2C(x, y, Char_Dot);
                        }
                        x += ColumnWidth;
                        cell >>= 4;
                    }
                }
                y += RowHeight;
            }
            PrintFoodCount();
        }
    }
    InitMan();
    StartMonsters();
    InitFires();
    InitPoints();
    UpdateSprites();
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
    byte x = ToCoord(column);
    byte y = ToCoord(row) + StageTop;
    if ((cell & Cell_Dot) != 0) {
        Put2C(x, y, Char_Dot);
    }
    else if ((cell & Cell_Food) != 0) {
        Put2C(x, y, Char_Food);
    }
    else {
        Erase2(x, y);
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