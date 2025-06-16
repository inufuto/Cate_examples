#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
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
    UpdateSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pCell, pByte;
        word vram;
        pCell = CellMap;
        pByte = pStageBytes;
        vram = Vram + VramWidth * StageTop;
        repeat (MapHeight) {
            repeat (MapWidth / 8) {
                byte b;
                b = *pByte;
                ++pByte;
                repeat (8) {
                    byte cell;
                    if ((b & 1) != 0) {
                        cell = Cell_Wall;
                        Put2C(vram, Char_Block);
                    }
                    else {
                        cell = Cell_Space;
                        Erase2(vram);
                    }
                    *pCell = cell;
                    ++pCell;
                    vram += 2;
                    b >>= 1;
                }
            }
            vram += VramWidth * 2 - VramWidth;
        }
    }
    InitMan();
    DrawItems();
    StartMonsters();
    InitPoints();
    InitIncreaser();
    UpdateSprites();
}


ptr<byte> CellMapPtr(byte x, byte y)
{
    return CellMap + ((y << 4) + x);
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) return Cell_Wall;
    return *CellMapPtr(x, y);
}
