#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Math.h"
#include "Sprite.h"
#include "Status.h"
// #include "VVram.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Point.h"
#include "Vram.h"

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
    // {
    //     constexpr byte Wall_Left = 0x01;
    //     constexpr byte Wall_Right = 0x02;
    //     constexpr byte Wall_Top = 0x04;
    //     constexpr byte Wall_Bottom = 0x08;
    //     constexpr byte Wall_All = 0x0f;
    //     {
    //         ptr<byte> pVVram = VVramBack;
    //         repeat (ColumnWidth * ColumnCount + 1) {
    //             pVVram = VPut(pVVram, Char_Wall | Wall_All);
    //         }
    //         ptr<byte> pCell = CellMap;
    //         ++pVVram;
    //         repeat (RowCount) {
    //             VPut(pVVram, Char_Wall | Wall_All);
    //             VPut(pVVram + VVramWidth, Char_Wall | Wall_All);
    //             VPut(pVVram + VVramWidth * 2, Char_Wall | Wall_All);
    //             ++pVVram;
    //             repeat (ColumnCount / ColumnsPerByte) {
    //                 byte cell = *pCell; ++pCell;
    //                 repeat (ColumnsPerByte) {
    //                     if ((cell & Cell_BottomWall) != 0) {
    //                         VPut(pVVram + VVramWidth * 2, Char_Wall | Wall_All);
    //                         VPut(pVVram + VVramWidth * 2 + 1, Char_Wall | Wall_All);
    //                     }
    //                     pVVram += 2;
    //                     if ((cell & Cell_RightWall) != 0) {
    //                         VPut(pVVram, Char_Wall | Wall_All);
    //                         VPut(pVVram + VVramWidth, Char_Wall | Wall_All);
    //                     }
    //                     VPut(pVVram + VVramWidth * 2, Char_Wall | Wall_All);
    //                     ++pVVram;
    //                     cell >>= 4;
    //                 }
    //             }
    //             pVVram += VVramWidth * 2 + 1;
    //         }
    //     }
    //     {
    //         ptr<byte> pVVram = VVramBack;
    //         byte y;
    //         for (y = 0; y < VVramHeight; ++y) {
    //             byte x;
    //             for (x = 0; x < VVramWidth; ++x) {
    //                 byte c = pVVram[0];
    //                 byte old = c;
    //                 if (x > 0 && pVVram[-1] != Char_Space) {
    //                     c &= ~Wall_Left;
    //                 }
    //                 if (pVVram[1] != Char_Space) {
    //                     c &= ~Wall_Right;
    //                 }
    //                 if (y > 0 && pVVram[-VVramWidth] != Char_Space) {
    //                     c &= ~Wall_Top;
    //                 }
    //                 if (y < VVramHeight - 1 && pVVram[VVramWidth] != Char_Space) {
    //                     c &= ~Wall_Bottom;
    //                 }
    //                 pVVram = VPut(pVVram, c);
    //             }
    //         }
    //     }
    //     {
            FoodCount = 0;
            // ptr<byte> pVVram = VVramBack + VVramWidth + 1;
            ptr<byte> pCell = CellMap;
            repeat (RowCount) {
                repeat (ColumnCount / ColumnsPerByte) {
                    byte cell = *pCell; ++pCell;
                    repeat (ColumnsPerByte) {
                        if ((cell & Cell_Food) != 0) {
                            // VPut2C(pVVram, Char_Food);
                            ++FoodCount;
                        }
                        // else if ((cell & Cell_Dot) != 0) {
                        //     VPut2C(pVVram, Char_Dot);
                        // }
                        // pVVram += ColumnWidth;
                        cell >>= 4;
                    }
                }
                // pVVram += VVramWidth * 2 + 2;
            }
            PrintFoodCount();
    //     }
    // }
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
    // ptr<byte> pVVram = VVramBack+VVramOffset(ToCoord(column), ToCoord(row));
    // if ((cell & Cell_Dot) != 0) {
    //     VPut2C(pVVram, Char_Dot);
    // }
    // else if ((cell & Cell_Food) != 0) {
    //     VPut2C(pVVram, Char_Food);
    // }
    // else {
    //     VErase2(pVVram);
    // }
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