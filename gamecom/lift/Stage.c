#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "VVram.h"
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
#include "Vram.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] CellMap;
static byte timeRate;

static void DrawStage()
{
    ClearVVram();

    ptr<byte> pVVram = VVram;
                        // _deb();
    *pVVram = Char_Roof_Left; ++pVVram;
    repeat (ColumnCount * ColumnWidth - 2) {
        *pVVram = Char_Roof_Center; ++pVVram;
    }
    *pVVram = Char_Roof_Right; ++pVVram;
    pVVram += (VVramWidth - ColumnCount * ColumnWidth);
    
    repeat (ColumnCount * ColumnWidth) {
        *pVVram = Char_Roof_Center; ++pVVram;
    }
    pVVram += (VVramWidth - ColumnCount * ColumnWidth);

    ptr<byte> pCell = CellMap;
    ptr<byte> pBits = pStage->floorBits;
    byte b = *pBits; ++pBits; 
    byte mask = 1;
    repeat (FloorCount - 1) {
        pVVram += VVramWidth * (FloorHeight - 1);
        repeat (ColumnCount) {
            byte cell;
            if ((b & mask) != 0) {
                cell = Cell_Type_Floor;
                repeat (ColumnWidth) {
                    *pVVram = Char_Floor; ++pVVram;
                }
            }
            else {
                cell = 0;
                pVVram += 2;
            }
            *pCell = cell; ++pCell;
            mask <<= 1;
            if (mask == 0) {
                b = *pBits; ++pBits; 
                mask = 1;
            }
        }
        pVVram += (VVramWidth - ColumnCount * ColumnWidth);
    }
    {
        pVVram += VVramWidth * (FloorHeight - 1);
        repeat (ColumnCount) {
            repeat (ColumnWidth) {
                *pVVram = Char_Floor; ++pVVram;
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
    DrawAll();
}


byte ToX(byte b)
{
    return (b & 0x0f) << 1;
}


byte ToY(byte b)
{
    return ((b & 0xf0) >> 2) + StageTop;
}
