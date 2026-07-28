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
// #include "VVram.h"

constexpr byte UnitHeight = CharHeight * 3 / 2;

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
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    CopyMemory(CellMap, pStage->bytes, ColumnCount / ColumnsPerByte * RowCount);
    {
        byte y = 0;
        {
            byte x = 0;
            repeat (ColumnWidth * ColumnCount + 1) {
                SetWall(x, y);
                ++x;
            }
        }
        ++y;
        ptr<byte> pCell = CellMap;
        repeat (RowCount) {
            byte x = 0;
            {
                byte yy = y;
                repeat (RowHeight) {
                    SetWall(x, yy);
                    ++yy;
                }
            }
            ++x;
            repeat (ColumnCount / ColumnsPerByte) {
                byte cell = *pCell; ++pCell;
                repeat (ColumnsPerByte) {
                    if ((cell & Cell_BottomWall) != 0) {
                        byte xx = x;
                        byte yy = y + RowHeight - 1;
                        repeat (ColumnWidth - 1) {
                            SetWall(xx, yy);
                            ++xx;
                        }
                    }
                    if ((cell & Cell_RightWall) != 0) {
                        byte xx = x + ColumnWidth - 1;
                        byte yy = y;
                        repeat (RowHeight - 1) {
                            SetWall(xx, yy);
                            ++yy;
                        }
                    }
                    SetWall(x + ColumnWidth - 1, y + RowHeight - 1);
                    x += ColumnWidth;
                    cell >>= (8 / ColumnsPerByte);
                }
            }
            y += RowHeight;
        }
        {
            FoodCount = 0;
            byte sprite = Sprite_Background;
            byte y = CharHeight * 2 + UnitHeight + 1;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                byte x = CharWidth;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            ShowSpriteXY(sprite, x, y, Pattern_Food, 11);
                            ++FoodCount;
                        }
                        else if ((cell & Cell_Dot) != 0) {
                            ShowSpriteXY(sprite, x, y, Pattern_Dot, 12);
                        }
                        ++sprite;
                        x += CharWidth * ColumnWidth;
                        cell >>= 4;
                    }
                }
                y += UnitHeight * RowHeight;
            }
            PrintFoodCount();
        }
    }
    InitMan();
    StartMonsters();
    InitFires();
    InitPoints();
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
    static const byte[ColumnCount] XTable = {
        CharWidth + 0 * ColumnWidth * CharWidth,
        CharWidth + 1 * ColumnWidth * CharWidth,
        CharWidth + 2 * ColumnWidth * CharWidth,
        CharWidth + 3 * ColumnWidth * CharWidth,
        CharWidth + 4 * ColumnWidth * CharWidth,
        CharWidth + 5 * ColumnWidth * CharWidth,
        CharWidth + 6 * ColumnWidth * CharWidth,
        CharWidth + 7 * ColumnWidth * CharWidth,
    };
    static const byte[RowCount] YTable = {
        CharHeight * 2 + UnitHeight + 0 * UnitHeight * RowHeight + 1,
        CharHeight * 2 + UnitHeight + 1 * UnitHeight * RowHeight + 1,
        CharHeight * 2 + UnitHeight + 2 * UnitHeight * RowHeight + 1,
        CharHeight * 2 + UnitHeight + 3 * UnitHeight * RowHeight + 1,
        CharHeight * 2 + UnitHeight + 4 * UnitHeight * RowHeight + 1,
    };
    ptr<byte> pCell = CellMapPtr(column, row);
    if ((column & 1) != 0) {
        *pCell = (*pCell & 0x0f) | (cell << 4);
    }
    else {
        *pCell = (*pCell & 0xf0) | (cell & 0x0f);
    }
    byte x = XTable[column];
    byte sprite = Sprite_Background + ((row << 3) + column);
    byte y = YTable[row];
    if ((cell & Cell_Dot) != 0) {
        ShowSpriteXY(sprite, x, y, Pattern_Dot, 12);
    }
    else if ((cell & Cell_Food) != 0) {
        ShowSpriteXY(sprite, x, y, Pattern_Food, 11);
    }
    else {
        HideSprite(sprite);
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