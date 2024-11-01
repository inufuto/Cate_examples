#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "VVram.h"
#include "Movable.h"
#include "Actor.h"
#include "Sprite.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Status.h"
#include "Man.h"
#include "Item.h"
#include "Monster.h"
#include "Point.h"
#include "Increaser.h"
#include "Vram.h"

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[MapWidth * MapHeight] CellMap;

void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
            }
        }
        pStage = p;
        pStageBytes = pStage->bytes;
    }
    InitItems();
    InitMonsters();
}


void InitTrying()
{
    {
        byte i;
        StageTime = 60;
        i = pStage->enemyCount;
        do {
            StageTime += 30;
            --i;
        } while (i != 0);
    }
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pCell, pByte;
        ptr<byte> pVVram;
        byte b, count;
        pCell = CellMap;
        pByte = pStageBytes;
        pVVram = VVram;
        b = *pByte;
        ++pByte;
        count = 8;
        repeat (MapHeight) {
            repeat (MapWidth) {
                byte cell;
                if ((b & 1) != 0) {
                    cell = Cell_Wall;
                    VPut2C(pVVram, Char_Block);
                }
                else {
                    cell = Cell_Space;
                    VErase2(pVVram);
                }
                *pCell = cell;
                ++pCell;
                pVVram += 2;
                b >>= 1;
                --count;
                if (count == 0) {
                    b = *pByte;
                    ++pByte;
                    count = 8;
                }
            }
            pVVram += VVramWidth * 2 - 2 * MapWidth;
        }
        repeat (MapWidth * 2) {
            *pVVram = Char_Fence; ++pVVram;
        }
    }
    InitMan();
    DrawItems();
    StartMonsters();
    InitPoints();
    InitIncreaser();
    DrawAll();
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) return Cell_Wall;
    return *CellMapPtr(x, y);
}
