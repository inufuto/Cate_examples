#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Movable.h"
#include "Sprite.h"
#include "Chars.h"
#include "Status.h"
#include "Item.h"
#include "Actor.h"
#include "Man.h"
#include "Lift.h"
#include "Monster.h"
#include "Point.h"

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] CellMap;
static byte timeRate;

static void DrawStage()
{
    ptr<byte> pVram;
    ptr<byte> pBits, pCell;
    byte b, mask;
    pVram = VramBack + VramRowSize * (StageTop - 2);

    pVram = Put(pVram, Char_Roof_Left);
    repeat (VramWidth - 2) {
        pVram = Put(pVram, Char_Roof_Center);
    }
    pVram = Put(pVram, Char_Roof_Right);
    repeat (VramWidth) {
        pVram = Put(pVram, Char_Roof_Center);
    }

    pCell = CellMap;
    pBits = pStage->floorBits;
    b = *pBits; ++pBits; 
    mask = 1;
    repeat (FloorCount - 1) {
        pVram += VramRowSize * (FloorHeight - 1);
        repeat (ColumnCount) {
            byte cell;
            if ((b & mask) != 0) {
                cell = Cell_Type_Floor;
                repeat (ColumnWidth) {
                    pVram = Put(pVram, Char_Floor);
                }
            }
            else {
                cell = 0;
                pVram += VramStep * 2;
            }
            *pCell = cell; ++pCell;
            mask <<= 1;
            if (mask == 0) {
                b = *pBits; ++pBits; 
                mask = 1;
            }
        }
    }
    {
        pVram += VramRowSize * (FloorHeight - 1);
        repeat (ColumnCount) {
            repeat (ColumnWidth) {
                pVram = Put(pVram, Char_Floor);
            }
            *pCell = Cell_Type_Floor; ++pCell;
        }
    }
}


void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        timeRate = 30;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
                if (timeRate != 0) {
                    timeRate -= 10;
                }
            }
        }
        pStage = p;
    }
    InitItems();
}


void InitTrying()
{
    HideAllSprites();
    UpdateSprites();
    ClearScreen();
    PrintStatus();
    DrawStage();
    InitLifts();
    DrawItems();
    InitMan();
    InitMonsters();
    InitPoints();
    {
        byte i;
        StageTime = 90;
        i = pStage->monsterCount;
        do {
            StageTime += timeRate;
            --i;
        } while (i != 0);
    }
    {
        ptr<byte> pCell, pLeft;
        byte rightBit;
        pCell = CellMap;
        repeat (FloorCount) {
            pLeft = pCell;
            rightBit = 0;
            repeat (ColumnCount) {
                byte cell;
                cell = *pCell;
                if ((cell & Cell_Type_Floor) != 0) {
                    *pCell |= rightBit;
                }
                else {
                    if ((cell & Cell_Type_LiftBit) != 0) {
                        while (pLeft != pCell) {
                            *pLeft |= Cell_LeftLift;
                            ++pLeft;
                        }
                        rightBit = Cell_RightLift;
                    }
                    else {
                        rightBit = 0;
                    }
                }
                ++pCell;
                if ((cell & Cell_Type_Floor) == 0) {
                    pLeft = pCell;
                }
            }
        }
    }
    PrintTime();
    UpdateSprites();
}


byte ToX(byte b)
{
    return (b & 0x0f) << 1;
}


byte ToY(byte b)
{
    return ((b & 0xf0) >> 2) + StageTop;
}


ptr<byte> CellMapPtr(byte x, byte y)
{
    byte offset;
    offset = (((y - StageTop) & 0xfc) << 2) + (x >> 1);
    return CellMap + offset;
}
