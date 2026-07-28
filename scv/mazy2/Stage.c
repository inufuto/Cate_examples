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

constexpr byte UnitHeight = CharHeight * 3 / 2;

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
        ClearWalls();
        ptr<byte> pMap = CellMap;
        byte sprite = Sprite_Background;
        byte spriteY = CharHeight * 2 + UnitHeight + 1;
        byte y = 0;
        repeat (RowCount) {
            byte spriteX = CharWidth;
            byte x = 0;
            repeat (ColumnCount) {
                byte cell = *pMap;
                if ((cell & Cell_Visible) != 0) {
                    SetWall(x, y);
                    SetWall(x + ColumnWidth, y);
                    SetWall(x, y + RowHeight);
                    SetWall(x + ColumnWidth, y + RowHeight);
                    if ((cell & Cell_TopWall) != 0) {
                        byte xx = x + 1;
                        repeat (ColumnWidth - 1) {
                            SetWall(xx, y); ++xx;
                        }
                    }
                    if ((cell & Cell_LeftWall) != 0) {
                        byte yy = y + 1;
                        repeat (RowHeight - 1) {
                            SetWall(x, yy); ++yy;
                        }
                    }
                    if ((cell & Cell_BottomWall) != 0) {
                        byte xx = x + 1;
                        byte yy = y + RowHeight;
                        repeat (ColumnWidth - 1) {
                            SetWall(xx, yy); ++xx;
                        }
                    }
                    if ((cell & Cell_RightWall) != 0) {
                        byte xx = x + ColumnWidth;
                        byte yy = y + 1;
                        repeat (RowHeight - 1) {
                            SetWall(xx, yy); ++yy;
                        }
                    }
                    {
                        byte c = cell & Cell_TypeMask;
                        if (c != 0) {
                            static const byte[] Colors = {
                                14, 14, 12
                            };
                            c -= Cell_DownStair;
                            c >>= 1;
                            byte pattern = Pattern_Stair + c;
                            c >>= 1;
                            byte color = Colors[c];
                            ShowSpriteXY(sprite, spriteX, spriteY, pattern, color);
                        }
                        else {
                            HideSprite(sprite);
                        }
                    }
                }
                else {
                    HideSprite(sprite);
                }
                ++pMap;
                ++sprite;
                spriteX += CharWidth * ColumnWidth;
                x += ColumnWidth;
            }
            spriteY += UnitHeight * RowHeight;
            y += RowHeight;
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
