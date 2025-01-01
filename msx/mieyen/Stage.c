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
        constexpr byte Wall_Left = 0x01;
        constexpr byte Wall_Right = 0x02;
        constexpr byte Wall_Top = 0x04;
        constexpr byte Wall_Bottom = 0x08;
        constexpr byte Wall_All = 0x0f;
        {
            word vram = Vram + VramWidth * StatusHeight;
            repeat (ColumnWidth * ColumnCount + 1) {
                vram = Put(vram, Char_Wall | Wall_All);
            }
            ptr<byte> pCell = CellMap;
            ++vram;
            repeat (RowCount) {
                Put(vram, Char_Wall | Wall_All);
                Put(vram + VramWidth, Char_Wall | Wall_All);
                Put(vram + VramWidth * 2, Char_Wall | Wall_All);
                ++vram;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_BottomWall) != 0) {
                            Put(vram + VramWidth * 2, Char_Wall | Wall_All);
                            Put(vram + VramWidth * 2 + 1, Char_Wall | Wall_All);
                        }
                        vram += 2;
                        if ((cell & Cell_RightWall) != 0) {
                            Put(vram, Char_Wall | Wall_All);
                            Put(vram + VramWidth, Char_Wall | Wall_All);
                        }
                        Put(vram + VramWidth * 2, Char_Wall | Wall_All);
                        ++vram;
                        cell >>= 4;
                    }
                }
                vram += VramWidth * 2 + 1;
            }
        }
        {
            word vram = Vram + VramWidth * StatusHeight;
            byte y;
            for (y = 0; y < VramHeight - StatusHeight; ++y) {
                byte x;
                for (x = 0; x < VramWidth; ++x) {
                    byte c = ReadVram(vram);
                    byte old = c;
                    if (x > 0 && ReadVram(vram - 1) != Char_Space) {
                        c &= ~Wall_Left;
                    }
                    if (ReadVram(vram + 1) != Char_Space) {
                        c &= ~Wall_Right;
                    }
                    if (y > 0 && ReadVram(vram - VramWidth) != Char_Space) {
                        c &= ~Wall_Top;
                    }
                    if (y < VramHeight - StatusHeight - 1 && ReadVram(vram + VramWidth) != Char_Space) {
                        c &= ~Wall_Bottom;
                    }
                    vram = Put(vram, c);
                }
            }
        }
        {
            FoodCount = 0;
            word vram = Vram + VramWidth * (StatusHeight + 1) + 1;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            Put2C(vram, Char_Food);
                            ++FoodCount;
                        }
                        else if ((cell & Cell_Dot) != 0) {
                            Put2C(vram, Char_Dot);
                        }
                        vram += ColumnWidth;
                        cell >>= 4;
                    }
                }
                vram += VramWidth * 2 + 2;
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
    word vram = VramAddress(ToCoord(column), ToCoord(row) + StatusHeight);
    if ((cell & Cell_Dot) != 0) {
        Put2C(vram, Char_Dot);
    }
    else if ((cell & Cell_Food) != 0) {
        Put2C(vram, Char_Food);
    }
    else {
        Erase2(vram);
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