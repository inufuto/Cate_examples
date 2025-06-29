#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Movable.h"
#include "Actor.h"
#include "Sprite.h"
#include "Chars.h"
#include "Status.h"
#include "Man.h"
#include "Item.h"
#include "Monster.h"
#include "Point.h"
#include "Increaser.h"
#include "VVram.h"

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[MapWidth * MapHeight] CellMap;

extern void _deb();
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
    // UpdateSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pCell, pByte;
        ptr<byte>  pVVram;
        pCell = CellMap;
        pByte = pStageBytes;
        pVVram = VVram;
        repeat (MapHeight) {
            repeat (MapWidth / 8) {
                byte b;
                b = *pByte;
                ++pByte;
                repeat (8) {
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
                }
            }
            pVVram += VVramWidth * 2 - StageWidth;
        }
    }
    InitMan();
    DrawItems();
    StartMonsters();
    InitPoints();
    InitIncreaser();
    // UpdateSprites();
    DrawFence();
}


ptr<byte> CellMapPtr(byte x, byte y)
{
    return CellMap + ((y << 4) + x);
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) {
        return Cell_Wall;
    }
                        if (y == 8) _deb();
    return *CellMapPtr(x, y);
}
