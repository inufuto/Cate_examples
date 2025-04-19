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
            ptr<byte> pVram = Vram + VramRowSize * StageTop;
            repeat (ColumnWidth * ColumnCount + 1) {
                pVram[0] = Char_Wall | Wall_All; pVram += VramStep;
                // pVram = Put(pVram, );
            }
            ptr<byte> pCell = CellMap;
            pVram += VramRowSize - (ColumnWidth * ColumnCount + 1) * VramStep;
            repeat (RowCount) {
                pVram[0] = Char_Wall | Wall_All;
                // Put(pVram, );
                pVram[VramRowSize] = Char_Wall | Wall_All;
                // Put(pVram + , );
                pVram[VramRowSize * 2] = Char_Wall | Wall_All;
                // Put(pVram + , );
                pVram += VramStep;
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_BottomWall) != 0) {
                            pVram[VramRowSize * 2] = Char_Wall | Wall_All;
                            // Put(pVram + , );
                            pVram[VramRowSize * 2 + VramStep] = Char_Wall | Wall_All;
                            // Put(pVram + , );
                        }
                        pVram += 2 * VramStep;
                        if ((cell & Cell_RightWall) != 0) {
                            pVram[0] = Char_Wall | Wall_All;
                            // Put(pVram, );
                            pVram[VramRowSize] = Char_Wall | Wall_All;
                            // Put(pVram + , );
                        }
                        pVram[VramRowSize * 2] = Char_Wall | Wall_All;
                        // Put(pVram + , );
                        pVram += VramStep;
                        cell >>= 4;
                    }
                }
                pVram += VramRowSize * 3 - (ColumnWidth * ColumnCount + 1) * VramStep;
            }
        }
        {
            ptr<byte> pVram = Vram + VramRowSize * StageTop;
            byte y;
            for (y = 0; y < VramHeight - StageTop; ++y) {
                byte x;
                for (x = 0; x < ColumnWidth * ColumnCount + 1; ++x) {
                    byte c = pVram[0];
                    byte old = c;
                    if (x > 0 && pVram[-VramStep] != Char_Space) {
                        c &= ~Wall_Left;
                    }
                    if (pVram[VramStep] != Char_Space) {
                        c &= ~Wall_Right;
                    }
                    if (y > 0 && pVram[-VramRowSize] != Char_Space) {
                        c &= ~Wall_Top;
                    }
                    if (y < VramHeight - StageTop - 1 && pVram[VramRowSize] != Char_Space) {
                        c &= ~Wall_Bottom;
                    }
                    pVram[0] = c; pVram += VramStep;
                    // pVram = Put(pVram, c);
                }
                pVram += VramRowSize - (ColumnWidth * ColumnCount + 1) * VramStep;
            }
        }
        {
            ptr<byte> pVram = Vram + VramRowSize * StageTop;
            repeat(VramHeight - StageTop) {
                repeat (ColumnWidth * ColumnCount + 1) {
                    pVram = Put(pVram, pVram[0]);
                }
                pVram += VramRowSize - (ColumnWidth * ColumnCount + 1) * VramStep;
            }
        }
        {
            FoodCount = 0;
            ptr<byte> pVram = Vram + VramRowSize * (StageTop + 1) + 1 * VramStep;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            Put2C(pVram, Char_Food);
                            ++FoodCount;
                        }
                        else if ((cell & Cell_Dot) != 0) {
                            Put2C(pVram, Char_Dot);
                        }
                        pVram += ColumnWidth * VramStep;
                        cell >>= 4;
                    }
                }
                pVram += VramRowSize * 3 - (ColumnWidth * ColumnCount) * VramStep;
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
    ptr<byte> pVram = VramPtr(ToCoord(column), ToCoord(row) + StageTop);
    if ((cell & Cell_Dot) != 0) {
        Put2C(pVram, Char_Dot);
    }
    else if ((cell & Cell_Food) != 0) {
        Put2C(pVram, Char_Food);
    }
    else {
        Erase2(pVram);
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