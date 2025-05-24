#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Sprite.h"
#include "Vram.h"
#include "Status.h"
#include "Man.h"
#include "Chars.h"
#include "Monster.h"
#include "Knife.h"
#include "Point.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount * RowCount] CellMap;
byte FloorCount;
byte CurrentFloor;
ptr<Floor> pFloor;
byte GoalX, GoalY;
bool Reached;
static byte InitialTime;

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


void InitStage() 
{
    {
        InitialTime = 30;
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
                if (InitialTime > 10) {
                    InitialTime -= 3;
                }
            }
        }
        pStage = p;
    }
    FloorCount = pStage->floorCount;
    {
        byte count1 = FloorCount;
        ptr<Floor> p = pStage->pFloors;
        while (count1 != 0) {
            byte count2 = p->stairCount;
            while (count2 != 0) {
                InitialTime += 5;
                --count2;
            }
            InitialTime += 15;
            --count1;
        }
    }
}


void InitTrying()
{
    StageTime = InitialTime;
    InitMonsters();
    InitKnives();
    InitPoints();
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    CurrentFloor = 0;
    Reached = false;
    InitMan();
    InitFloor();
    UpdateSprites();
}


static void InitStairs(ptr<byte> pStairs, byte type, byte count)
{
    while (count != 0) {
        byte b = *pStairs; ++pStairs;
        byte column = b >> 4;
        byte row = b & 0x0f;
        *CellMapPtr(column, row) |= type;
        --count;
    }
}


static bool SetCellVisible(ptr<byte> pMap)
{
    byte cell = *pMap;
    if ((cell & Cell_Visible) == 0) {
        cell |= Cell_NextScan;
        *pMap = cell;
        return true;
    }
    return false;
}

void InitFloor()
{
    pFloor = pStage->pFloors + CurrentFloor;
    {
        ptr<byte> pSource = pFloor->bytes;
        ptr<byte> pMap = CellMap;
        byte row;
        for (row = 0; row < RowCount; ++row) {
            byte column;
            for (column = 0; column < ColumnCount;) {
                byte source = *pSource; ++pSource;
                repeat (4) {
                    if (column == ColumnCount) break;
                    byte cell = source & 3;
                    source >>= 2;
                    if (column == 0 || (pMap[-1] & Cell_RightWall) != 0) {
                        cell |= Cell_LeftWall;
                    }
                    if (row == 0 || (pMap[-ColumnCount] & Cell_BottomWall) != 0) {
                        cell |= Cell_TopWall;
                    }
                    *pMap = cell; ++pMap;
                    ++column;
                }
            }
        }
    }
    InitStairs(pFloor->pStairs, Cell_DownStair, pFloor->stairCount);
    if (CurrentFloor > 0) {
        ptr<Floor> pUpper = pStage->pFloors + (CurrentFloor - 1);
        InitStairs(pUpper->pStairs, Cell_UpStair, pUpper->stairCount);
    }
    if (CurrentFloor == 0) {
        byte b = pStage->goal;
        byte column = b >> 4;
        byte row = b & 0x0f;
        *CellMapPtr(column, row) |= Cell_Goal;
        GoalX = ToCoord(column);
        GoalY = ToCoord(row);
    }
    {
        byte startColumn = ToGrid(Man.x);
        byte startRow = ToGrid(Man.y);
        *CellMapPtr(startColumn, startRow) |= Cell_NextScan;
    }
    {
        bool changed;
        loop:
        changed = false;
        ptr<byte> pMap = CellMap;
        repeat (ColumnCount * RowCount) {
            byte cell = *pMap;
            if ((cell & Cell_NextScan) != 0) {
                cell |= Cell_Visible;
                cell &= ~Cell_NextScan;
                *pMap = cell;
                if ((cell & Cell_TopWall) == 0) {
                    if (SetCellVisible(pMap - ColumnCount)) {
                        changed = true;    
                    }
                }
                if ((cell & Cell_BottomWall) == 0) {
                    if (SetCellVisible(pMap + ColumnCount)) {
                        changed = true;    
                    }
                }
                if ((cell & Cell_LeftWall) == 0) {
                    if (SetCellVisible(pMap - 1)) {
                        changed = true;    
                    }
                }
                if ((cell & Cell_RightWall) == 0) {
                    if (SetCellVisible(pMap + 1)) {
                        changed = true;    
                    }
                }
                if (changed) goto loop;
            }
            ++pMap;
        }
    }
    {
        static const byte[] Chars = {
            Char_Space, Char_Space, Char_Space, Char_Space,
            Char_StairUp, Char_StairUp + 1, Char_StairUp + 2, Char_StairUp + 3,
            Char_StairDown, Char_StairDown + 1, Char_StairDown + 2, Char_StairDown + 3,
            Char_Goal, Char_Goal + 1, Char_Goal + 2, Char_Goal + 3,
        };
        word vram = Vram + VramRowSize * StageTop;
        ptr<byte> pMap = CellMap;
        repeat (1 + 3 * ColumnCount) {
            vram = Put(vram, Char_Space);
        }
        vram -= (1 + 3 * ColumnCount) * VramStep;
        repeat (RowCount) {
            repeat (4) {
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 1 * VramStep;
            }
            vram += -VramRowSize * 4;
            repeat (ColumnCount) {
                byte cell = *pMap;
                if ((cell & Cell_Visible) != 0) {
                    vram = Put(vram, Char_Wall);
                    {
                        byte c = (cell & Cell_TopWall) != 0 ? Char_Wall : Char_Space;
                        repeat (2) {
                            vram = Put(vram, c);
                        }
                    }
                    vram = Put(vram, Char_Wall);
                    vram += VramRowSize - 4 * VramStep;

                    {
                        byte c = (cell & Cell_LeftWall) != 0 ? Char_Wall : Char_Space;
                        repeat (2) {
                            vram = Put(vram, c);
                            vram += VramRowSize - 1 * VramStep;
                        }
                    }
                    vram += 1 * VramStep - VramRowSize * 2;

                    {
                        ptr<byte> p = Chars + (cell & 0x0c);
                        repeat (2) {
                            repeat (2) {
                                vram = Put(vram, *p); ++p;
                            }
                            vram += VramRowSize - 2 * VramStep;
                        }
                        vram += 2 * VramStep - VramRowSize * 2;
                    }
                    {
                        byte c = (cell & Cell_RightWall) != 0 ? Char_Wall : Char_Space;
                        repeat (2) {
                            vram = Put(vram, c);
                            vram += VramRowSize - 1 * VramStep;
                        }
                    }
                    vram += -3 * VramStep;

                    vram = Put(vram, Char_Wall);
                    {
                        byte c = (cell & Cell_BottomWall) != 0 ? Char_Wall : Char_Space;
                        repeat (2) {
                            vram = Put(vram, c);
                        }
                    }
                    vram = Put(vram, Char_Wall);
                    vram += -VramRowSize * 3 - 1 * VramStep;
                }
                else {
                    vram += VramRowSize + 1 * VramStep;
                    repeat (3) {
                        repeat (3) {
                            vram = Put(vram, Char_Space);
                        }
                        vram += VramRowSize - 3 * VramStep;
                    }
                    vram += 2 * VramStep - VramRowSize * 4;
                }
                ++pMap;
            }
            vram += VramRowSize * 3 - 30 * VramStep;
        }
    }
    ShowMonsters();
    ShowKnives();
}


void ChangeFloor(byte floor)
{
    CurrentFloor = floor;
    InitFloor();
}
