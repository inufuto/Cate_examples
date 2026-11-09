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

constexpr byte Char_Wall = 0x55;

const byte[] FoodChars = {
    0x2a, 0x8a, 0x0a, 0x0a,
};
static const byte[] DotChars = {
    0x02, 0x08, 0x20, 0x80,
};
static const byte[] SpaceChars = {
    0x00, 0x00, 0x00, 0x00,
};

ptr<Stage> pStage;
byte[ColumnCount / ColumnsPerByte * RowCount] CellMap;

void InitStage()
{
    ClearScreen();
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

static ptr<byte> DrawCell(ptr<byte> pVram, byte cell, bool right)
{
    ptr<byte> pChars;
    if ((cell & Cell_Food) != 0) {
        pChars = FoodChars;
        ++FoodCount;
    }
    else if ((cell & Cell_Dot) != 0) {
        pChars = DotChars;
    }
    else {
        pChars = SpaceChars;
    }
    return Put2S(pVram, pChars, right);
}

void InitTrying()
{
    ClearScreen();
    HideAllSprites();
    PrintStatus();
    CopyMemory(CellMap, pStage->bytes, ColumnCount / ColumnsPerByte * RowCount);
    {
        {
            ptr<byte> pCell = CellMap;
            ptr<byte> pVram = Vram + VramRowSize * StageTop;
            byte row;
            for (row = 0; row < RowCount; ++row) {
                byte column = 0;
                bool right = false;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if (row < RowCount - 1 && (cell & Cell_BottomWall) != 0) {
                            ptr<byte> pBottom = pVram + VramRowSize * 2;
                            bool bottomRight = right;
                            pBottom = Put(pBottom, Char_Wall, bottomRight);
                            Put(pBottom, Char_Wall, !bottomRight);
                        }
                        ++pVram;
                        if (column < ColumnCount - 1 && (cell & Cell_RightWall) != 0) {
                            Put(pVram, Char_Wall, right);
                            Put(pVram + VramRowSize, Char_Wall, right);
                        }
                        if (row < RowCount - 1 && column < ColumnCount - 1) {
                            Put(pVram + VramRowSize * 2, Char_Wall, right);
                        }
                        right = !right;
                        if (!right) {
                            ++pVram;
                        }
                        cell >>= 4;
                        ++column;
                    }
                }
                pVram += VramRowSize * 3 - ColumnWidth * ColumnCount / 2;
            }
        }
        {
            ptr<byte> pVram = Vram + VramRowSize * StageTop + (VramWidth - 1);
            repeat (StageHeight) {
                Put(pVram, 0x44, true);
                pVram += VramRowSize;
            }
        }
        {
            FoodCount = 0;
            ptr<byte> pVram = Vram + VramRowSize * StageTop;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                bool right = false;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        pVram = DrawCell(pVram, cell, right);
                        right = !right;
                        if (!right) {
                            ++pVram;
                        }
                        cell >>= 4;
                    }
                }
                pVram += VramRowSize * 3 - (ColumnWidth * ColumnCount) / 2;
            }
            PrintFoodCount();
        }
    }
    InitMan();
    StartMonsters();
    InitFires();
    InitPoints();
    SwitchStatus(1);
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
    byte x = ToCoord(column) - 1;
    ptr<byte> pVram = Vram + VramOffset(x, ToCoord(row) + (StageTop - 1));
    bool right = (x & 1) != 0;
    DrawCell(pVram, cell, right);
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